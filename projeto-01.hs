-- INPUT DATA TYPES -------------------------------------------

-- paths: origin destination mode time
data Path = Path String String String Float deriving (Read, Show, Eq)
lineToPath line = read ("Path "++line')::Path
  where line' = let wordz = words line
                in unwords $ (map show $ init $ wordz) ++ [last $ wordz]

-- transports: mode wait
data Transport = Transport String Float deriving (Read, Show, Eq)
lineToTransport line = read ("Transport "++line')::Transport
  where line' = let wordz = words line
                in unwords $ (map show $ init $ wordz) ++ [last $ wordz]

-- route: start end
data Route = Route String String deriving (Read, Show, Eq)
lineToRoute line = read ("Route "++line')::Route
  where line' = unwords $ map show $ words line

-- MISCELLANEOUS FUNCTIONS ------------------------------------

part :: (a -> Bool) -> [a] -> ([a], [a])
part f = (\(xs, ys)-> (xs, tail ys)) . span f

firstOrNull :: [[a]] -> [a]
firstOrNull [] = []
firstOrNull (x:_) = x

-- MAIN -------------------------------------------------------

main = do
  input <- getContents
  let linez = lines input
      (pathz, linez') = part (not . null) linez
      (transportz, routez) = part (not . null) linez'
      transports = map lineToTransport transportz
      Route start end = lineToRoute $ head routez
      -- creates a list of paths filtering out unnecessary ones for tracing the route
      paths = filter (\(Path o d _ _) -> d /= start && o /= end) $ map lineToPath pathz
      -- creates a graph with the input paths as edges and expands them creating new ones based on the transport mode and time
      graph' = foldl addEdge (foldl addVertex [] paths) paths
      graph = (expandEdges graph') `addWaitsOf` transports
      distances = graph `initDistancesFrom` start -- creates a priority queue for distances between vertices
      previous = dijkstra graph distances -- creates a list of the edges in a shortest path from start to end
  putStrLn $ traceRoute graph start end previous
  print $ evaluateRouteTime graph start end previous

traceRoute :: Graph -> String -> String -> Previous -> String
traceRoute _ _ _ [] = "Não há caminho"
traceRoute graph start v previous
  | v == start = v
  | otherwise = (traceRoute graph start u previous) ++ " " ++ modeUV ++ " " ++ v
    where u = previous `getPrevious` v
          modeUV = previous `getModeFromPrevious` v

evaluateRouteTime :: Graph -> String -> String -> Previous -> Float
evaluateRouteTime _ _ _ [] = 1.0/0.0
evaluateRouteTime graph start v previous
  | v == start = 0.0
  | otherwise = (evaluateRouteTime graph start u previous) + timeUV
    where u = previous `getPrevious` v
          edgesUV = filter (\(Edge t _ _) -> t == v) $ graph `getEdges` u
          timeUV = time $ foldl1 (\e e' -> if time e' < time e then e' else e) edgesUV

dijkstra :: Graph -> Distances -> Previous
dijkstra graph distances = dijkstra' graph distances []

dijkstra' :: Graph -> Distances -> Previous -> Previous
dijkstra' graph [] previous = previous
dijkstra' graph distances previous =
  let ((u, distU), distancez) = extractMin distances
      (distances', previous') = relax (u, distU) graph distancez previous
  in dijkstra' graph distances' previous'

relax :: (String, Float) -> Graph -> Distances -> Previous -> (Distances, Previous)
relax (vertex, distFromStart) graph distances previous =
  let sources = map (fst) distances -- get vertices still in the priority queue
      neighbors = filter (\(Edge t _ _) -> t `elem` sources) $ graph `getEdges` vertex -- get vertex's neighbors still in the priority queue
  in foldl (\(ds, ps) (Edge neighbor mode lengthUV) ->
              let altDist = distFromStart + lengthUV -- u.d + |u → v|, where u.d is the estimated shortest |s → ... → u|
                  currentDist = ds `getDistance` neighbor -- v.d, where v.d is the estimated shortest |s → ... → v|
              in if altDist < currentDist
                 then (setDistance ds neighbor altDist, setPrevious ps neighbor vertex mode) -- v.d = u.d + |u → v| and v.π = u
                 else (ds, ps)
     ) (distances, previous) neighbors

-- GRAPH DATA TYPES -------------------------------------------

data Edge = Edge { target :: String
                 , mode :: String
                 , time :: Float
                 } deriving (Show, Eq)
data Vertex = Vertex { source :: String
                     , edges :: [Edge]
                     } deriving (Show, Eq)
type Graph = [Vertex]

addVertex :: Graph -> Path -> Graph
addVertex graph (Path o d _ _) = graph `addVertex'` o `addVertex'` d

addVertex' :: Graph -> String -> Graph
addVertex' [] src = [Vertex src []]
addVertex' (vertex:vertices) src
    | source vertex == src = vertex : vertices
    | otherwise = vertex : (vertices `addVertex'` src)

addEdge :: Graph -> Path -> Graph
addEdge [] (Path o d m t) = [Vertex o [Edge d m t]]
addEdge ((Vertex source edges):vertices) (Path o d m t)
    | source == o = (Vertex source ((Edge d m t):edges)) : vertices
    | otherwise = (Vertex source edges) : (vertices `addEdge` (Path o d m t))

getEdges :: Graph -> String -> [Edge]
getEdges graph src = firstOrNull $ map edges $ filter (\(Vertex source _) -> source == src) graph

addWaitsOf :: Graph -> [Transport] -> Graph
addWaitsOf graph transports =
  foldl (\vertices (Vertex source edges) ->
    let edges' = foldl (\edges' (Edge d m t) ->
                          (Edge d m (t + transports `getWaitTime` m)) : edges'
                 ) [] edges
    in (Vertex source edges') : vertices
  ) [] graph

getWaitTime :: [Transport] -> String -> Float
getWaitTime _ "a-pe" = 0.0
getWaitTime [] _ = 0.0
getWaitTime ((Transport m w):ts) mode
    | m `sameAs` mode = w/2
    | otherwise = ts `getWaitTime` mode
    where sameAs m m' = firstOrNull (words m) == firstOrNull (words m')

expandEdges :: Graph -> Graph
expandEdges graph = foldl (\graph' (Vertex s _) -> graph' `expandEdgesFrom` s) graph graph

expandEdgesFrom :: Graph -> String -> Graph
expandEdgesFrom graph start = let startEdges = graph `getEdges` start
                                  sourceEdges = filter (\(Edge _ m _) -> m /= "a-pe") startEdges
                                  visitedEdges = filter (\(Edge _ m _) -> m == "a-pe") startEdges
                              in (graph `expandEdgesFrom'` start) sourceEdges visitedEdges

expandEdgesFrom' :: Graph -> String -> [Edge] -> [Edge] -> Graph
expandEdgesFrom' graph _ [] _ = graph
expandEdgesFrom' graph start sourceEdges visitedEdges =
    let graph' = foldl (\vertices (Edge d m t) ->
                    let sameAs m m' = firstOrNull (words m) == firstOrNull (words m')
                        targetEdges = filter (\(Edge d' m' t') -> d' /= start && m' `sameAs` m) $ graph `getEdges` d
                    in foldl (\graph' (Edge d' m' t') ->
                                let mode = m ++ " " ++ d ++ " " ++ m'
                                    time = t + t'
                                in graph' `addEdge` (Path start d' mode time)
                       ) graph targetEdges
                 ) [] sourceEdges
        sourceEdges' = filter (\(Edge d m t) -> not ((Edge d m t) `isOn` visitedEdges || (Edge d m t) `elem` sourceEdges || (Edge d m t) `elem` visitedEdges)) $ graph' `getEdges` start
        visitedEdges' = visitedEdges ++ sourceEdges
    in (graph' `expandEdgesFrom'` start) sourceEdges' visitedEdges'


isOn _ [] = False
isOn (Edge d m t) ((Edge d' m' t'):xs)
    | d == d' = True
    | otherwise = isOn (Edge d m t) xs

-- SHORTEST PATH DISTANCE ESTIMATION LIST DATA TYPE -----------

type Distances = [(String, Float)] -- [(source, dist)], where
                                   -- dist is the estimated distance from start to source

-- initial distance estimation
infinity :: Float
infinity = 1.0/0.0

initDistancesFrom :: Graph -> String -> Distances
initDistancesFrom graph start = initDistancesFrom' graph start []
  where initDistancesFrom' [] _ distances = distances
        initDistancesFrom' ((Vertex source edges):vertices) start distances
          | source == start = (source, 0.0) : initDistancesFrom' vertices start distances
          | otherwise = (source, infinity) : initDistancesFrom' vertices start distances

setDistance :: Distances -> String -> Float -> Distances
setDistance [] source dist = [(source, dist)]
setDistance (d:ds) source dist
    | source `sameAs` d = (source, dist) : ds
    | otherwise = d : setDistance ds source dist
    where sameAs s (s', _) = s == s'

getDistance :: Distances -> String -> Float
getDistance [] _ = infinity
getDistance (d:ds) vertex
  | fst d == vertex = snd d
  | otherwise = ds `getDistance` vertex

extractMin :: Distances -> ((String, Float), Distances)
extractMin distances = (min, filter (/= min) distances)
  where min = foldl1 minimum distances
        minimum min' x = if dist x < dist min' then x else min'
        dist (source, dist) = dist

-- SHORTEST PATH PREDECESSOR LIST DATA TYPE -------------------

type Previous = [(String, String, String)] -- [(source, prev, mode)], where
                                           -- prev is the previous vertex in an optimal path from start

setPrevious :: Previous -> String -> String -> String -> Previous
setPrevious [] source prev mode = [(source, prev, mode)]
setPrevious (p:ps) source prev mode
    | source `sameAs` p = (source, prev, mode) : ps
    | otherwise = p : setPrevious ps source prev mode
    where sameAs s (s', _, _) = s == s'

-- returns the vertex prior to v in a path: start → ... → u → v
getPrevious :: Previous -> String -> String
getPrevious ((v, u, _):ps) vertex
    | v == vertex = u
    | otherwise = ps `getPrevious` vertex

-- returns the mode from the last transport taken to v in a path: start → ... → u → v
getModeFromPrevious :: Previous -> String -> String
getModeFromPrevious ((v, _, mode):ps) vertex
    | v == vertex = mode
    | otherwise = ps `getModeFromPrevious` vertex

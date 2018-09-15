-- calcule a média aritmética ponderada dada uma entrada na forma "valor peso"
main = do
  input <- getContents
  let vwList = map words $ lines input
  let vwTupleList = 
        foldl (\acc (v:w:vws) -> 
          let value = read v::Float
              weight = read w::Float
          in (value, weight) : acc) 
        [] vwList
  print $ weightedMean vwTupleList

weightedMean :: (Fractional a) => [(a,a)] -> a
weightedMean vws = (vwSum vws) / (wSum vws)
  where vwSum vws = foldl (\acc (v,w) -> acc + (v*w)) 0.0 vws
        wSum vws = foldl (\acc (v,w) -> acc + w) 0.0 vws

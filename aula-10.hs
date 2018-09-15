-- calcule a média aritmética ponderada dada uma entrada na forma "valor peso"
main :: IO ()
main = getContents >>= print . weightedMean . map lineToVW . lines

lineToVW :: String -> VW
lineToVW line = read ("VW "++line)::VW

weightedMean :: [VW] -> Float
weightedMean vws = (vwSum vws) / (wSum vws)
  where vwSum vws = foldl (\acc (VW v w) -> acc + v*w) 0.0 vws
        wSum vws = foldl (\acc (VW v w) -> acc + w) 0.0 vws

data VW = VW Float Float deriving (Read)

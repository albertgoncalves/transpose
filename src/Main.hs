import Data.Bifunctor (first)
import Draw (draw)
import Parse (parse)
import System.Environment (getArgs)
import Transpose (transpose)

-- NOTE: `$ ./bin/main $(shuf -n 1 -e P1 m2 M2 m3 M3 P4 A4 d5 P5 m6 M6 m7 M7) $(shuf -n 1 -e $(ls assets/*))`
main :: IO ()
main = do
  args <- getArgs
  case args of
    [interval, path] -> do
      chords <- readFile path
      putStrLn $ draw $ map (map $ fmap $ first $ transpose $ read interval) $ parse chords
    _ -> undefined

module Draw where

import Data.List (intercalate)
import Primitives (Note)

pairs :: [a] -> [(a, a)]
pairs [] = []
pairs (x : y : zs) = (x, y) : pairs zs
pairs _ = undefined

interleave :: [a] -> [a] -> [a]
interleave (x : xs) ys = x : interleave ys xs
interleave [] ys = ys

lengths :: [[a]] -> [Int]
lengths [x] = [length x]
lengths (x : y : zs) = max (length x) (length y) : lengths (y : zs)
lengths _ = undefined

width :: Int
width = 8

row :: [Maybe (Note, String)] -> String
row =
  ('|' :)
    . (++ "|")
    . intercalate "|"
    . map (uncurry $ (++) . (++ " "))
    . pairs
    . map (take (width - 1) . (++ repeat ' ') . maybe "" (uncurry $ (++) . show))

grid :: Int -> String
grid = (++ "+") . intercalate "" . (`replicate` take width ('+' : repeat '-'))

draw :: [[Maybe (Note, String)]] -> String
draw chords =
  intercalate "\n" $
    grid (length $ head chords) : interleave (map row chords) (map grid $ lengths chords)

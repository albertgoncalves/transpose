module Draw where

import Data.List (intercalate)
import Primitives (Chord (..))

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
width = 10

row :: [Maybe Chord] -> String
row =
  ('|' :)
    . (++ "|")
    . intercalate "|"
    . map (uncurry $ (++) . (++ " "))
    . pairs
    . map (take (width - 1) . (++ repeat ' ') . maybe "" show)

grid :: Int -> String
grid = (++ "+") . intercalate "" . (`replicate` take width ('+' : repeat '-'))

draw :: [[Maybe Chord]] -> String
draw chords =
  intercalate "\n" $
    grid (length $ head chords) : interleave (map row chords) (map grid $ lengths chords)

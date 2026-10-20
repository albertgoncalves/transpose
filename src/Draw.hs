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
grid = (++ "+") . concat . (`replicate` take width ('+' : repeat '-'))

draw :: [[Maybe Chord]] -> String
draw chords = intercalate "\n" $ interleave (map grid widths) (map row chords)
  where
    lengths = map length chords
    widths = zipWith max (0 : lengths) (lengths ++ [0])

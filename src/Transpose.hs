module Transpose where

import Primitives (Accidental (..), Interval (..), Letter (..), Note (..), semitones, steps)

class Transpose a where
  transpose :: Interval -> a -> a

instance Transpose Letter where
  transpose interval letter = fromSteps $ (steps letter + steps interval) `mod` 7
    where
      fromSteps :: Int -> Letter
      fromSteps 0 = A
      fromSteps 1 = B
      fromSteps 2 = C
      fromSteps 3 = D
      fromSteps 4 = E
      fromSteps 5 = F
      fromSteps 6 = G
      fromSteps _ = undefined

instance Transpose Note where
  transpose interval noteFrom@(Note letterFrom _) = Note letterTo accidentals
    where
      letterTo = transpose interval letterFrom
      distance =
        ((((semitones letterTo - semitones noteFrom) - semitones interval) + 6) `mod` 12) - 6
      accidentals
        | distance < 0 = replicate (-distance) Sharp
        | 0 < distance = replicate distance Flat
        | otherwise = []

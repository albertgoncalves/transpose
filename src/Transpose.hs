module Transpose where

import Primitives
  ( Accidental (..),
    Chord (..),
    Interval (..),
    Letter (..),
    Note (..),
    semitones,
    steps,
  )

class Transpose a where
  transpose :: Interval -> a -> a

instance Transpose Letter where
  transpose interval letter = toEnum $ (fromEnum letter + steps interval) `mod` 7

instance Transpose Note where
  transpose interval noteFrom@(Note letterFrom _) = Note letterTo accidentals
    where
      letterTo = transpose interval letterFrom
      distance =
        ((((semitones letterTo - semitones noteFrom) - semitones interval) + 6) `mod` 12) - 6
      accidentals = replicate (-distance) Sharp ++ replicate distance Flat

instance Transpose Chord where
  transpose interval (Chord note suffix) = Chord (transpose interval note) suffix
  transpose interval (SlashChord note suffix bass) =
    SlashChord (transpose interval note) suffix (transpose interval bass)

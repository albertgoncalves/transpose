module Primitives where

import Data.List (intercalate)

class Steps a where
  steps :: a -> Int

class Semitones a where
  semitones :: a -> Int

data Letter = A | B | C | D | E | F | G
  deriving (Eq)

instance Show Letter where
  show A = "A"
  show B = "B"
  show C = "C"
  show D = "D"
  show E = "E"
  show F = "F"
  show G = "G"

instance Steps Letter where
  steps A = 0
  steps B = 1
  steps C = 2
  steps D = 3
  steps E = 4
  steps F = 5
  steps G = 6

instance Semitones Letter where
  semitones A = 9
  semitones B = 11
  semitones C = 0
  semitones D = 2
  semitones E = 4
  semitones F = 5
  semitones G = 7

data Accidental = Flat | Sharp
  deriving (Eq)

instance Show Accidental where
  show Flat = "b"
  show Sharp = "#"

instance Semitones Accidental where
  semitones Flat = -1
  semitones Sharp = 1

data Note = Note Letter [Accidental]
  deriving (Eq)

instance Show Note where
  show (Note letter accidentals) = intercalate "" $ show letter : map show accidentals

instance Semitones Note where
  semitones (Note letter accidentals) = (semitones letter + sum (map semitones accidentals)) `mod` 12

data Interval
  = Dim1
  | Per1
  | Aug1
  | Min2
  | Maj2
  | Min3
  | Maj3
  | Dim4
  | Per4
  | Aug4
  | Dim5
  | Per5
  | Aug5
  | Min6
  | Maj6
  | Min7
  | Maj7
  deriving (Eq)

instance Read Interval where
  readsPrec _ "d1" = [(Dim1, [])]
  readsPrec _ "P1" = [(Per1, [])]
  readsPrec _ "A1" = [(Aug1, [])]
  readsPrec _ "m2" = [(Min2, [])]
  readsPrec _ "M2" = [(Maj2, [])]
  readsPrec _ "m3" = [(Min3, [])]
  readsPrec _ "M3" = [(Maj3, [])]
  readsPrec _ "d4" = [(Dim4, [])]
  readsPrec _ "P4" = [(Per4, [])]
  readsPrec _ "A4" = [(Aug4, [])]
  readsPrec _ "d5" = [(Dim5, [])]
  readsPrec _ "A5" = [(Aug5, [])]
  readsPrec _ "P5" = [(Per5, [])]
  readsPrec _ "m6" = [(Min6, [])]
  readsPrec _ "M6" = [(Maj6, [])]
  readsPrec _ "m7" = [(Min7, [])]
  readsPrec _ "M7" = [(Maj7, [])]
  readsPrec _ _ = undefined

instance Show Interval where
  show Dim1 = "d1"
  show Per1 = "P1"
  show Aug1 = "A1"
  show Min2 = "m2"
  show Maj2 = "M2"
  show Min3 = "m3"
  show Maj3 = "M3"
  show Dim4 = "d4"
  show Per4 = "P4"
  show Aug4 = "A4"
  show Dim5 = "d5"
  show Per5 = "P5"
  show Aug5 = "A5"
  show Min6 = "m6"
  show Maj6 = "M6"
  show Min7 = "m7"
  show Maj7 = "M7"

instance Steps Interval where
  steps Dim1 = 0
  steps Per1 = 0
  steps Aug1 = 0
  steps Min2 = 1
  steps Maj2 = 1
  steps Min3 = 2
  steps Maj3 = 2
  steps Dim4 = 3
  steps Per4 = 3
  steps Aug4 = 3
  steps Dim5 = 4
  steps Per5 = 4
  steps Aug5 = 4
  steps Min6 = 5
  steps Maj6 = 5
  steps Min7 = 6
  steps Maj7 = 6

instance Semitones Interval where
  semitones Dim1 = 11
  semitones Per1 = 0
  semitones Aug1 = 1
  semitones Min2 = 1
  semitones Maj2 = 2
  semitones Min3 = 3
  semitones Maj3 = 4
  semitones Dim4 = 4
  semitones Per4 = 5
  semitones Aug4 = 6
  semitones Dim5 = 6
  semitones Per5 = 7
  semitones Aug5 = 8
  semitones Min6 = 8
  semitones Maj6 = 9
  semitones Min7 = 10
  semitones Maj7 = 11

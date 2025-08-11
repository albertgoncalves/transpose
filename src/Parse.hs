module Parse where

import Primitives (Accidental (..), Letter (..), Note (..))
import Text.ParserCombinators.ReadP
  ( ReadP,
    char,
    choice,
    eof,
    many,
    many1,
    readP_to_S,
    sepBy1,
    string,
    (<++),
  )

newline :: ReadP Char
newline = char '\n'

letter :: ReadP Letter
letter =
  choice
    [ A <$ char 'A',
      B <$ char 'B',
      C <$ char 'C',
      D <$ char 'D',
      E <$ char 'E',
      F <$ char 'F',
      G <$ char 'G'
    ]

accidental :: ReadP Accidental
accidental = (Flat <$ char 'b') <++ (Sharp <$ char '#')

note :: ReadP Note
note = Note <$> letter <*> many accidental

chord :: ReadP (Note, String)
chord =
  (,)
    <$> note
    <*> choice
      (map string ["", "^", "^b5", "7", "7alt", "7b5", "7sus4", "6", "-", "-7", "-7b5", "-6", "*7"])

row :: ReadP [Maybe (Note, String)]
row = choice [Just <$> chord, pure Nothing] `sepBy1` char ','

rows :: ReadP [[Maybe (Note, String)]]
rows = many1 (row <* newline)

parse :: String -> [[Maybe (Note, String)]]
parse = fst . head . readP_to_S (rows <* eof)

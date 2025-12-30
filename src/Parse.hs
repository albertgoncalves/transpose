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

suffixes :: [String]
suffixes =
  [ "",
    "sus2",
    "add9",
    "6",
    "7",
    "7alt",
    "7sus2",
    "7sus4",
    "^",
    "^b5",
    "7b5",
    "-",
    "-add9",
    "-6",
    "-7",
    "-7b5",
    "*",
    "*7"
  ]

chord :: ReadP (Note, String)
chord = (,) <$> note <*> choice (map string suffixes)

row :: ReadP [Maybe (Note, String)]
row = choice [Just <$> chord, pure Nothing] `sepBy1` char ','

rows :: ReadP [[Maybe (Note, String)]]
rows = many1 (row <* newline)

parse :: String -> [[Maybe (Note, String)]]
parse = fst . head . readP_to_S (rows <* eof)

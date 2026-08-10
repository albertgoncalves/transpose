module Parse where

import Primitives (Accidental (..), Chord (..), Letter (..), Note (..))
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
  choice $
    map
      (uncurry (<$) . fmap char)
      [(A, 'A'), (B, 'B'), (C, 'C'), (D, 'D'), (E, 'E'), (F, 'F'), (G, 'G')]

accidental :: ReadP Accidental
accidental = (Flat <$ char 'b') <++ (Sharp <$ char '#')

note :: ReadP Note
note = Note <$> letter <*> many accidental

suffix :: ReadP String
suffix =
  choice $
    map
      string
      [ "",
        "sus2",
        "sus4",
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
        "-b6",
        "-6",
        "-7",
        "-7b5",
        "*",
        "*7",
        "+"
      ]

chord :: ReadP Chord
chord = (SlashChord <$> note <*> suffix <*> (char '/' *> note)) <++ (Chord <$> note <*> suffix)

row :: ReadP [Maybe Chord]
row = ((Just <$> chord) <++ pure Nothing) `sepBy1` char ','

rows :: ReadP [[Maybe Chord]]
rows = many1 (row <* newline)

parse :: String -> [[Maybe Chord]]
parse = fst . head . readP_to_S (rows <* eof)

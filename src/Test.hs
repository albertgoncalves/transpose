import Primitives (Accidental (..), Chord (..), Interval (..), Letter (..), Note (..), semitones)
import Test.HUnit (runTestTTAndExit, test, (~?=))
import Transpose (transpose)

main :: IO ()
main =
  runTestTTAndExit $
    test $
      zipWith (~?=) (map (read . show) intervals) intervals
        ++ map
          (\(interval, noteFrom, noteTo) -> transpose interval noteFrom ~?= noteTo)
          [ (Dim1, Note B [], Note B [Flat]),
            (Per1, Note B [Sharp], Note B [Sharp]),
            (Aug1, Note C [Flat], Note C []),
            (Min2, Note B [Sharp], Note C [Sharp]),
            (Maj2, Note B [Flat], Note C []),
            (Min3, Note F [Flat], Note A [Flat, Flat]),
            (Maj3, Note A [Sharp], Note C [Sharp, Sharp]),
            (Dim4, Note A [], Note D [Flat]),
            (Per4, Note F [], Note B [Flat]),
            (Aug4, Note F [Sharp], Note B [Sharp]),
            (Dim5, Note B [Flat], Note F [Flat]),
            (Per5, Note B [], Note F [Sharp]),
            (Aug5, Note A [], Note E [Sharp]),
            (Min6, Note D [], Note B [Flat]),
            (Maj6, Note E [], Note C [Sharp]),
            (Min7, Note G [Sharp, Sharp], Note F [Sharp, Sharp]),
            (Maj7, Note C [Flat, Flat, Flat], Note B [Flat, Flat, Flat])
          ]
        ++ [ semitones (Note C [Flat, Sharp]) ~?= 0,
             transpose Maj7 B ~?= A,
             transpose Maj7 (Chord (Note C []) "") ~?= Chord (Note B []) "",
             transpose Min2 (SlashChord (Note C []) "" (Note D []))
               ~?= SlashChord (Note D [Flat]) "" (Note E [Flat])
           ]
  where
    intervals = [Per1, Min2, Maj2, Min3, Maj3, Per4, Aug4, Dim5, Per5, Min6, Maj6, Min7, Maj7]

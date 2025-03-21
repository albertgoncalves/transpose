import Primitives (Accidental (..), Interval (..), Letter (..), Note (..), semitones)
import Test.HUnit (runTestTTAndExit, test, (~?=))
import Transpose (transpose)

main :: IO ()
main =
  runTestTTAndExit $
    test $
      zipWith (~?=) (map (read . show) intervals) intervals
        ++ [transpose Maj7 B ~?= A]
        ++ map
          (\(interval, noteFrom, noteTo) -> transpose interval noteFrom ~?= noteTo)
          [ (Per1, Note B [Sharp], Note B [Sharp]),
            (Min2, Note B [Sharp], Note C [Sharp]),
            (Maj2, Note B [Flat], Note C []),
            (Min3, Note F [Flat], Note A [Flat, Flat]),
            (Maj3, Note A [Sharp], Note C [Sharp, Sharp]),
            (Per4, Note F [], Note B [Flat]),
            (Aug4, Note F [Sharp], Note B [Sharp]),
            (Dim5, Note B [Flat], Note F [Flat]),
            (Per5, Note B [], Note F [Sharp]),
            (Min6, Note D [], Note B [Flat]),
            (Maj6, Note E [], Note C [Sharp]),
            (Min7, Note G [Sharp, Sharp], Note F [Sharp, Sharp]),
            (Maj7, Note C [Flat, Flat, Flat], Note B [Flat, Flat, Flat])
          ]
        ++ [semitones (Note C [Flat, Sharp]) ~?= 0]
  where
    intervals = [Per1, Min2, Maj2, Min3, Maj3, Per4, Aug4, Dim5, Per5, Min6, Maj6, Min7, Maj7]

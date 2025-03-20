import Primitives (Accidental (..), Interval (..), Letter (..), Note (..))
import Test.HUnit (runTestTTAndExit, test, (~?=))
import Transpose (transpose)

main :: IO ()
main =
  runTestTTAndExit $
    test
      [ transpose Maj7 B ~?= A,
        transpose Per1 (Note B [Sharp]) ~?= Note B [Sharp],
        transpose Min2 (Note B [Sharp]) ~?= Note C [Sharp],
        transpose Maj2 (Note B [Flat]) ~?= Note C [],
        transpose Min3 (Note F [Flat]) ~?= Note A [Flat, Flat],
        transpose Maj3 (Note A [Sharp]) ~?= Note C [Sharp, Sharp],
        transpose Per4 (Note F []) ~?= Note B [Flat],
        transpose Aug4 (Note F [Sharp]) ~?= Note B [Sharp],
        transpose Dim5 (Note B [Flat]) ~?= Note F [Flat],
        transpose Per5 (Note B []) ~?= Note F [Sharp],
        transpose Min6 (Note D []) ~?= Note B [Flat],
        transpose Maj6 (Note E []) ~?= Note C [Sharp],
        transpose Min7 (Note G [Sharp, Sharp]) ~?= Note F [Sharp, Sharp],
        transpose Maj7 (Note C [Flat, Flat, Flat]) ~?= Note B [Flat, Flat, Flat]
      ]

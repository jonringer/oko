import Test.Hspec

import FindFile
import TestParser
import TestCLI

main :: IO ()
main = hspec $ do
    findFileTest
    testParser
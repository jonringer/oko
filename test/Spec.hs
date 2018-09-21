import Test.Hspec

import FindFile
import TestParser
import TestCLI
import TestPrinter

main :: IO ()
main = hspec $ do
    findFileTest
    testParser
    testCLI
    testPrinter
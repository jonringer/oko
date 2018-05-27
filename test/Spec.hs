import Test.Hspec

import FindFile
import TestParser

main :: IO ()
main = hspec $ do
    findFileTest
    testParser
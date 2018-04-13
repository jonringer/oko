import Test.Hspec
import Test.QuickCheck
import Test.Hspec.Megaparsec
import Text.Megaparsec

import Oko.Types
import Oko.Lexer

main :: IO ()
main = hspec $
    describe "Oko.Lexer" $
        it "can parse an assignment" $ do
            parse assign "" "x = 3" `shouldParse` Assign "x" "3"
            parse assign "" "x=3" `shouldParse` Assign "x" "3"

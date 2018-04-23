import Test.Hspec
import Test.QuickCheck
import Test.Hspec.Megaparsec
import Text.Megaparsec

import Oko.Types
import Oko.Lexer

main :: IO ()
main = hspec $
    describe "Oko.Lexer" $ do
        describe "Assignment" $ do
            it "can parse a simple assignment" $ do
                parse assign "" "x = 3" `shouldParse` Assign "x" "3"
                parse assign "" "x=3" `shouldParse` Assign "x" "3"

            it "can parse a conditional assimgnet" $ do
                parse assign "" "x ?= HELLO" `shouldParse` CondAssign "x" "HELLO"

        describe "Recipe" $ do
            it "parses recipes with no args" $
                parse recipe "" "someRecipe:\n echo \"hello\"\n" `shouldParse` Recipe "someRecipe" [] ["echo \"hello\""]
            it "parses recipes with args" $ do
                let actual = parse recipe "" "someRecipe $a $b:\n echo \"hello\"\n"
                    expected = Recipe "someRecipe" ["a", "b"] ["echo \"hello\""]
                actual `shouldParse` expected

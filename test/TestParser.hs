module TestParser where

import Test.Hspec
import Test.Hspec.Megaparsec
import Text.Megaparsec

import Oko.Types
import Oko.Lexer

testParser =
    describe "Oko.Lexer" $ do
        describe "Assignment" $ do
            it "can parse a simple assignment" $ do
                parse assign "" "x = 3" `shouldParse` Assign "x" "3"
                parse assign "" "x=3"   `shouldParse` Assign "x" "3"
                parse assign "" "x =3"  `shouldParse` Assign "x" "3"
                parse assign "" "x= 3"  `shouldParse` Assign "x" "3"
                parse assign "" "x=3\n" `shouldParse` Assign "x" "3"

            it "can parse a conditional assimgnet" $ do
                parse assign "" "x ?= HELLO" `shouldParse` CondAssign "x" "HELLO"
                parse assign "" "x?=HELLO"   `shouldParse` CondAssign "x" "HELLO"
                parse assign "" "x ?=HELLO"  `shouldParse` CondAssign "x" "HELLO"
                parse assign "" "x?= HELLO"  `shouldParse` CondAssign "x" "HELLO"

        describe "Recipe" $ do
            it "parses recipes with no args" $ do
                let actual   = parse recipe "" "someRecipe:\n echo \"hello\"\n" 
                    expected = Recipe "someRecipe" [] ["echo \"hello\""]
                actual `shouldParse` expected
            it "parses recipes with args" $ do
                let actual   = parse recipe "" "someRecipe $a $b:\n echo \"hello\"\n"
                    expected = Recipe "someRecipe" ["a", "b"] ["echo \"hello\""]
                actual `shouldParse` expected
        
        describe "Entire File" $ do
            it "parse assignments and recipes together" $ do
                let actual    = parse commandFile "" "x=3\nsomeRecipe $a:\n echo \"hi\"\n"
                    expected  = [Left $ Assign "x" "3", Right $ Recipe "someRecipe" ["a"] ["echo \"hi\""] ]
                actual `shouldParse` expected

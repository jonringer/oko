module TestPrinter where

import Oko.Printer
import Oko.Types
import Test.Hspec

testPrinter =
    describe "Oko.Printer" $ do
        describe "Recipes" $ do
            it "creates a basic summary" $ do
                summaryRecipe (Recipe "task1" ["this"] []) `shouldBe` "task1 this"
            it "creates a basic list entry" $ do
                listRecipe (Recipe "something" ["a"] []) `shouldBe` "something"

        describe "CommandFile" $ do
            it "should list the summaries of commands available" $ do
                let file = [Right (Recipe "task1" ["a"] []), Right (Recipe "task2" [] [])]
                summaryFile file `shouldBe` "task1 a\ntask2"
            it "should print a short list of commands available" $ do
                let file = [Right (Recipe "task1" ["a"] []), Right (Recipe "task2" [] [])]
                listFile file `shouldBe` "task1\ntask2"
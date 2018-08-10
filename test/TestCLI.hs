module TestCLI where

import Options.Applicative
import Options.Applicative.Extra
import Test.Hspec

import Oko.Types
import OkoCLI

shouldParse :: (HasCallStack, Show a, Eq a) => ParserResult a -> a -> Expectation
shouldParse x expected = case x of
  Success result -> result `shouldBe` expected
  Failure e -> expectationFailure $ "failed to parse: " ++ fst (renderFailure e "test")
  CompletionInvoked _ -> expectationFailure $ "expected result, got completion"

p = execParserPure defaultPrefs $ info okoOpts briefDesc
testCLI = do
    describe "Parse Arguments" $ do
        describe "--list" $ do
            it "parses it in happy case" $ do
                p ["--list"] `shouldParse` List True
        describe "--summary" $ do
            it "parses it in happy case" $ do
                p ["--summary"] `shouldParse` Summary True
        describe "--list" $ do
            it "parses it in happy case" $ do
                p ["something"] `shouldParse` Command ["something"]
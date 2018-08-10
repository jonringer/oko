module TestCLI where

import Options.Applicative
import Test.Hspec

import OkoCLI

shouldParse :: (HasCallStack, Show a, Eq a) => ParserResult a -> a -> Expectation
shouldParse x expected = case x of
  Success result -> result `shouldBe` expected
  Failure e -> expectationFailure $ "failed to parse: " ++ fst (renderFailure e "test")
  CompletionInvoked _ -> expectationFailure $ "expected result, got completion"

shouldFailParse :: (HasCallStack, Show a) => ParserResult a -> Expectation
shouldFailParse x = case x of
  Success result -> expectationFailure $ "Got successful parsing of arguments: " ++ show result
  Failure e -> return () 
  CompletionInvoked _ -> expectationFailure $ "expected failure, got completion"

p = execParserPure defaultPrefs $ info okoOpts briefDesc
testCLI = do
    describe "Parse Arguments" $ do
        describe "--list" $ do
            it "parses it in happy case" $ do
                p ["--list"] `shouldParse` List True
        describe "--summary" $ do
            it "parses it in happy case" $ do
                p ["--summary"] `shouldParse` Summary True
        describe "COMMAND" $ do
            it "parses it in happy case" $ do
                p ["something"] `shouldParse` Command ["something"]
                p ["something","with","lots"] `shouldParse` Command ["something","with","lots"]
        describe "multiple arguments" $ do
            it "fails when multiple options are given" $ do
                shouldFailParse $ p ["--summary","--list"] 
                shouldFailParse $ p ["--summary","--help","--list"] 
                
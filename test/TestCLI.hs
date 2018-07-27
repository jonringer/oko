module TestCLI where

import Options.Applicative
import Test.Hspec

import Oko.Types
import OkoCLI

p = execParserPure defaultPrefs $ info okoOpts briefDesc
testCLI = do
    describe "Parse Arguments" $ do
        describe "--list" $ do
            it "parses it correctly" $ do
                p ["--list"] `shouldBe` (Success (List True))

module FindFile where

import Test.Hspec

import Filesystem.Path.CurrentOS
import Oko

findFileTest =
    describe "FindFile" $ do
        describe "Parent Traversal" $ do
            it "search at each parent level" $ do
                let a = fromText "/some/really/long/dir/structure/"
                    actual = parents a
                length actual `shouldBe` 5  
                head actual `shouldBe` fromText "/some/really/long/dir/structure/"
                actual !! 1 `shouldBe` fromText "/some/really/long/dir/"
                actual !! 2 `shouldBe` fromText "/some/really/long/"
                actual !! 3 `shouldBe` fromText "/some/really/"
                actual !! 4 `shouldBe` fromText "/some/"
          
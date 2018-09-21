module Oko.Printer where

import Oko.Types
import Data.Text (Text)
import qualified Data.Text as T
import Data.Monoid
import Data.Either

summaryRecipe :: Recipe -> Text
summaryRecipe (Recipe name [] _) = T.pack name
summaryRecipe (Recipe name args _) = (T.pack name) <> " " <> (T.pack $ unwords args)

listRecipe :: Recipe -> Text
listRecipe (Recipe name _ _) = T.pack name

summaryFile :: CommandFile -> Text
summaryFile = T.intercalate "\n" . map summaryRecipe . rights

listFile :: CommandFile -> Text
listFile = T.intercalate "\n" . map listRecipe . rights
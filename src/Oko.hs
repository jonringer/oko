module Oko
    ( tmpMain,
      parents
    ) where

import Prelude hiding (FilePath)
import Filesystem.Path.CurrentOS (parent, root, FilePath(..))

tmpMain :: IO ()
tmpMain = putStrLn "coming soon :)"

parents :: FilePath -> [FilePath]
parents x = let stop = root x
                parents' y = y : parents' (parent y)
            in  takeWhile (/= stop) $ parents' x
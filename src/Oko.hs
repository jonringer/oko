module Oko
    ( parents,
     runCommandWithFile 
    ) where

import Prelude hiding (FilePath)
import Filesystem.Path.CurrentOS (parent, root, encodeString, decodeString, FilePath(..))
import System.Directory (findFile)
import System.Exit (die)
import Oko.Types
import OkoCLI
import Oko.Lexer (commandFile)
import Oko.Printer
import Text.Megaparsec
import Data.Void

parents :: FilePath -> [FilePath]
parents x = let stop = root x
                parents' y = y : parents' (parent y)
            in  takeWhile (/= stop) $ parents' x

runOkoCommand :: OkoOptions -> CommandFile -> IO ()
runOkoCommand (List _) file = print $ listFile file
runOkoCommand _ _ = putStrLn "Not yet implemented!! :("

runCommandWithFile :: String -> String -> OkoOptions -> IO ()
runCommandWithFile name dir opts = do
    file <- findFile (map encodeString $ parents $ decodeString dir) name
    case (file) of
        Just file' -> do
            fileContents <- readFile file'
            runCommandWithContents opts (parse commandFile file' fileContents)
        Nothing    -> die $ 
            "could not find command file with name \"" 
            ++ name ++ "\" in any parent of working directory: " ++ dir

runCommandWithContents :: OkoOptions -> Either (ParseError Char Data.Void.Void) CommandFile -> IO ()
runCommandWithContents opts parseValue =
    case parseValue of
        Left bundle -> print bundle
        Right xs -> runOkoCommand opts xs
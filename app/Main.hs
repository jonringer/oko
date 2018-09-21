module Main where

import OkoCLI
import Options.Applicative
import Data.Semigroup((<>))
import System.Directory
import Oko
import Oko.Types

main :: IO ()
main = execCommand =<< customExecParser (prefs showHelpOnEmpty) opts
    where
        opts = info (okoOpts <**> helper)
                (  fullDesc
                <> progDesc "Command Runner"
                <> header "Easy to use command runner" )

execCommand :: OkoOptions -> IO ()
execCommand opts = do
    currentDir <- getCurrentDirectory
    runCommandWithFile "commandfile" currentDir opts
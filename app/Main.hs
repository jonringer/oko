module Main where

import OkoCLI
import Options.Applicative
import Data.Semigroup((<>))

main :: IO ()
main = print =<< customExecParser (prefs showHelpOnEmpty) opts
    where
        opts = info (okoOpts <**> helper)
                (  fullDesc
                <> progDesc "Command Runner"
                <> header "Easy to use command runner" )

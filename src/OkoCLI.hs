module OkoCLI where

import Options.Applicative
import Data.Semigroup ((<>))

data OkoOptions 
    = Command [String]
    | List Bool
    | Summary Bool
    deriving (Eq, Show)

okoList :: Parser OkoOptions
okoList = List <$> switch
                    (  long  "list"
                    <> short 'l'
                    <> help  "List names only of available commands.")

okoSummary :: Parser OkoOptions
okoSummary = Summary <$> switch
                     (  long  "summary"
                     <> short 's'
                     <> help  "List information of available commands.")

okoCommand :: Parser OkoOptions
okoCommand = Command <$> some (argument str (metavar "COMMAND ARGS.."))

okoOpts :: Parser OkoOptions
okoOpts =   okoList
        <|> okoSummary
        <|> okoCommand
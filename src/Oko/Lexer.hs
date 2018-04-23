module Oko.Lexer where

import Control.Monad (void)
import Data.Void
import Text.Megaparsec
import Text.Megaparsec.Char
import Text.Megaparsec.Expr
import qualified Text.Megaparsec.Char.Lexer as L

import Oko.Types

type Parser = Parsec Void String

sc :: Parser ()
sc = L.space space1 lineCmnt blockCmnt
  where
    lineCmnt  = L.skipLineComment "#"
    blockCmnt = L.skipBlockComment "/*" "*/"

lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc

symbol :: String -> Parser String
symbol = L.symbol sc

identifier :: Parser String
identifier = lexeme $ (:) <$> letterChar <*> many alphaNumChar

value :: Parser String
value = lexeme $ many latin1Char

assignOper :: Parser String
assignOper = lexeme $ symbol "="

condAssignOper :: Parser String
condAssignOper = lexeme $ symbol "?="

assign :: Parser Assignment
assign = condAssign
         <|> simpleAssign

simpleAssign :: Parser Assignment
simpleAssign = try $ lexeme $ Assign <$> identifier <*> (assignOper *> value)

condAssign :: Parser Assignment
condAssign = try $ lexeme $ CondAssign <$> identifier <*> (condAssignOper *> value)

arg :: Parser String
arg = lexeme $ char '$' *> some alphaNumChar

command :: Parser String
command = space1 *> takeWhile1P (Just "Command") (/= '\n') <* try eol

recipe :: Parser Recipe
recipe = try $ Recipe <$> identifier <*> many arg <* char ':' <*> many command
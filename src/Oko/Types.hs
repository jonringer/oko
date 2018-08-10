module Oko.Types where

type ExprLHS = String
type ExprRHS = String

type Name = String
type Commands = [String]
type ArgNames = [String]

data Assignment
    = Assign ExprLHS ExprRHS
    | CondAssign ExprLHS ExprRHS
    deriving (Eq, Show)

data Recipe
    = Recipe Name ArgNames Commands
    deriving (Eq, Show)

type Statement
    = Either Assignment Recipe

type CommandFile = [Statement]

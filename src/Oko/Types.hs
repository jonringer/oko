module Oko.Types where

type ExprLHS = String
type ExprRHS = String

data Assignment
    = Assign ExprLHS ExprRHS
    | CondAssign ExprLHS ExprRHS
    deriving (Eq, Show)


type Name = String
type Commands = [String]
type ArgNames = [String]

data Recipe
    = Recipe Name ArgNames Commands
    deriving (Eq, Show)

type Assignments = [Assignment]
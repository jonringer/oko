module Oko.Types where

type ExprLHS = String
type ExprRHS = String

data Assignment
    = Assign ExprLHS ExprRHS
    | CondAssign ExprLHS ExprRHS
    deriving (Eq, Show)

type Assignments = [Assignment]
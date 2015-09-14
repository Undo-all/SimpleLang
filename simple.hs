module Simple where

import Text.ParserCombinators.Parsec (ParseError)

data Error = WrongTypeToPrint Type
           | WhenParsing ParseError
           deriving (Eq, Show)

type Name = String

data Type = NumberType
          | VoidType
          deriving (Eq, Show)

data Expr = Print Expr
          | Atom Literal
          deriving (Eq, Show)

data Literal = Number Double
             deriving (Eq, Show)


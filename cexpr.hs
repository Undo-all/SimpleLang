{-# LANGUAGE TypeSynonymInstances, 
             FlexibleInstances #-}

module CExpr ( Pretty(..)
             , CFile
             , CDeclaration(..)
             , CVar(..)
             , CType(..)
             , CExpr(..)
             , CLiteral(..)) where

import Data.List (intercalate)

unlist :: [String] -> String
unlist = intercalate ", "

class Pretty a where
    pretty :: a -> String

type Name = String

type CFile = [CDeclaration]

instance Pretty CFile where
    pretty = unlines . map pretty

-- Function definitions are both declarations and expressions.

data CDeclaration = CFuncDecl CVar [CVar] [CExpr]
                  deriving (Eq, Show)

instance Pretty CDeclaration where
    pretty (CFuncDecl (CVar t n) args body) =
      pretty t ++ " " ++ n ++ "(" ++ unlist (map pretty args) ++ ") {\n" ++
      intercalate ";\n" (map pretty body) ++ ";\n}"

data CVar = CVar CType Name
          deriving (Eq, Show)

instance Pretty CVar where
    pretty (CVar t n) = pretty t ++ " " ++ n

data CType = CInt
           | CDouble
           | CChar
           | CPointer CType
           deriving (Eq, Show)

instance Pretty CType where
    pretty CInt = "int"
    pretty CDouble = "double"
    pretty CChar = "char"
    pretty (CPointer t) = show t ++ "*"

data CExpr = CCall Name [CExpr]
           | CAtom CLiteral
           deriving (Eq, Show)

instance Pretty CExpr where
    pretty (CCall n args) = n ++ "(" ++ unlist (map pretty args) ++ ")"
    pretty (CAtom lit)    = pretty lit

data CLiteral = CLitReal Double
              | CLitStr String
              deriving (Eq, Show)

instance Pretty CLiteral where
    pretty (CLitReal n) = show n
    pretty (CLitStr s)  = show s

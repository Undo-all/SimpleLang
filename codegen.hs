module Codegen where

import Control.Monad.State
import Simple
import CExpr

generateC :: [Expr] -> CFile
generateC xs = [CInclude "<stdio.h>", CFuncDecl (CVar CInt "main") [] $ map generateCExpr xs]

generateCExpr :: Expr -> CExpr
generateCExpr (Atom (Number n)) = CAtom (CLitReal n)
generateCExpr (Print n) = CCall "printf" [CAtom (CLitStr "%f\n"), generateCExpr n]


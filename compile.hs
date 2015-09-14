module Compile where

import Simple
import Codegen
import CExpr
import Parse
import Check

compile :: FilePath -> String -> Either Error String
compile f xs = either (Left . WhenParsing) compile' $ parseFile f xs

compile' :: [Expr] -> Either Error String
compile' xs = case typecheck xs of
                Left err  -> Left err
                _         -> Right (pretty $ generateC xs)


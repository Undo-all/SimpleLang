module Check (typecheck) where

import Simple

getType :: Expr -> Type
getType (Atom (Number _)) = NumberType
getType (Print _)         = VoidType

typecheckExpr :: Expr -> Either Error ()
typecheckExpr (Print n) = case getType n of
                            NumberType -> Right ()
                            VoidType   -> Left $ WrongTypeToPrint VoidType
typecheckExpr (Atom (Number _)) = Right ()

typecheck :: [Expr] -> Either Error ()
typecheck xs = case mapM typecheckExpr xs of
                 Left err -> Left  err
                 _        -> Right ()


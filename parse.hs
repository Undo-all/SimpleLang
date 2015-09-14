module Parse (parseFile) where

import Simple
import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Number (floating2)

parseFile = parse parseExprs

parseExprs = parseExpr `endBy` ((newline >> return ()) <|> eof)

parseExpr = parseParens
        <|> parsePrint
        <|> Atom <$> parseLiteral
        <?> "expression"

parseParens = between (char '(' <* spaces) (char ')') (parseExpr <* spaces)

parsePrint = Print <$> (string "print" *> space *> parseExpr)

parseLiteral = Number <$> floating2 True
           <?> "literal"


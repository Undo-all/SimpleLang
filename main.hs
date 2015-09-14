module Main where

import Compile
import System.Environment (getArgs)

main :: IO ()
main = do
    args <- getArgs
    case args of
      [file] -> let cFile = takeWhile (/='.') file ++ ".c"
                in do xs <- readFile file
                      case compile file xs of
                          Right compiled -> writeFile cFile compiled
                          Left err       -> print err
      _      -> print "USAGE: simple <file>"


module Main where

import System.IO
import Parser
import Algo

-- MUL (LD (#b), ADD (LD (#a), LD (#1)))
-- ADD (SUB (LD (#a), LD (#b)), MUL (LD (#e), ADD (LD (#c), LD (#d))))

main = do
    l <- getLine
    -- ops <- parseOperands l
    print . showInOrder . assignDefs 1 .  parseOperands $ l
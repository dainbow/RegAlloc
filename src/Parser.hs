{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

module Parser (parseOperands) where

import Base
import Text.Parsec.Language (emptyDef)
import Text.Parsec.Token qualified as T
import Text.ParserCombinators.Parsec as P

parseOperands :: String -> Operand
parseOperands s = case P.parse operand "" s of
  Left e -> error $ "error parsing operands: " ++ show e
  Right op -> op

operand = try operandConstant <|> try operandOperation

operandConstant = do
  try whiteSpace
  string "#"
  whiteSpace
  Constant <$> word

operandOperation = do
  try whiteSpace
  name <- word
  whiteSpace
  uses <- option [] (parens (operand `sepBy` comma))
  return $ Operation name Nothing uses

lexer = T.makeTokenParser emptyDef

whiteSpace = many (char ' ')

comma = T.comma lexer

parens = between (char '(') (char ')')

word = many1 (noneOf " (,)#")
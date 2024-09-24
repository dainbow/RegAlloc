module Base (Operand (..)) where

data Operand
  = Constant String
  | Operation
      { opName :: String,
        opUses :: [Operand]
      }
  deriving (Show)

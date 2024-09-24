module Base
  ( Operand (..),
    isConstant,
    regPrefix,
    allEqual,
    showDefValue,
    extractDef
  )
where

data Operand
  = Constant String
  | Operation
      { opName :: String,
        opDef :: Maybe Int,
        opUses :: [Operand]
      }
  deriving (Show)

isConstant (Constant _) = True
isConstant _ = False

extractDef (Operation _ a _) = a
extractDef _ = Nothing

regPrefix = "R"

showDefValue (Constant name) = "#" ++ name
showDefValue Operation {opDef = Just def} = regPrefix ++ show def
showDefValue _ = error "Trying to show define value of unassigned operation"

allEqual [] = True
allEqual (x : xs) = all (== x) xs
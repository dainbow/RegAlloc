module Algo
  ( assignDefs,
    showInOrder,
  )
where

import Base
import Data.List (sortBy)
import Data.Maybe

label :: Operand -> Int
label (Operation _ _ uses)
  | all isConstant uses = 1
label (Operation _ _ uses) =
  let labels = map label $ filter (not . isConstant) uses
      maxOfLabs = maximum labels
   in if allEqual labels
        then maxOfLabs + 1
        else maxOfLabs

assignDefs :: Int -> Operand -> Operand
assignDefs b o@Operation {opUses = uses}
  | all isConstant uses = o {opDef = Just b}
assignDefs b o@Operation {opUses = uses} =
  let labels = map label $ filter (not . isConstant) uses
      newUses =
        if allEqual labels
          then zipWith (\s op -> assignDefs (b + s) op) [0 ..] uses
          else map (assignDefs b) uses
      newDef = Just $ maximum . mapMaybe extractDef $ newUses
   in o
        { opDef = newDef,
          opUses = newUses
        }

showInOrder :: Operand -> String
showInOrder o@(Operation name (Just def) uses) =
  ( concatMap (showInOrder . snd)
      . sortBy (\(idx, op) (idx', op') -> compare (label op', idx') (label op, idx))
      . zip [0 ..]
      . filter (not . isConstant)
  )
    uses
    ++ name
    ++ " "
    ++ showDefValue o
    ++ " "
    ++ show (map showDefValue uses)
    ++ "\n"
module Main where

import Data.Map as Map
import Nix.Eval
import Nix.Parser
import Nix.Types
import System.Environment

nix :: FilePath -> IO ()
nix path = do
    res <- parseNixFile path
    case res of
        Failure e -> error $ "Parse failed: " ++ show e
        Success n -> do
            top <- evalExpr n (Fix (NVSet Map.empty)) -- evaluate top level
            print top

main :: IO ()
main = do
    [path] <- getArgs
    nix path

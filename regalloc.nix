{ pkgs ? import <nixpkgs> { } }:
(pkgs.haskellPackages.extend
  (pkgs.haskell.lib.compose.packageSourceOverrides { regalloc = ./.; }))

{ pkgs ? import <nixpkgs> { } }:
(import ./regalloc.nix { }).shellFor {
  packages = p: [ p.regalloc ];
  withHoogle = true;
  buildInputs = [ pkgs.haskell-language-server ];
}

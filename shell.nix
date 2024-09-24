{ pkgs ? import <nixpkgs> {}}:
(pkgs.haskellPackages.extend (pkgs.haskell.lib.compose.packageSourceOverrides {
  regalloc = ./.;
})).shellFor {
  packages = p: [ p.regalloc ];
  withHoogle = true;
  buildInputs = [ pkgs.haskell-language-server ];
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = {nixpkgs, ...}: let
    forEachSystem = function:
      nixpkgs.lib.genAttrs ["x86_64-linux"] (system: function nixpkgs.legacyPackages.${system});
  in {
    packages = forEachSystem (pkgs: rec {
      pekka-kana-2 = pkgs.callPackage ./package.nix {};
      default = pekka-kana-2;
    });
  };
}

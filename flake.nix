{
  description = "abels website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    fenix.url = "github:nix-community/fenix/f2eb76a4605b0f055e2a9eac47fe1797f19d21c1";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      fenix,
      ...
    }:
    {
      devShells = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          rustPkg =
            with fenix.packages.${system};
            combine [
              targets.wasm32-unknown-unknown.latest.rust-std
              (latest.withComponents [
                "rust-src"
                "rustc-dev"
                "llvm-tools-preview"
                "cargo"
                "clippy"
                "rustc"
                "rustfmt"
                "rust-analyzer"
              ])
            ];
        in
        {
          default =
            with pkgs;
            mkShell {
              nativeBuildInputs = [
                rustPkg
                wasm-pack
                nodejs_latest
                libgcc.lib
              ];
            };
        }
      );
    };
}

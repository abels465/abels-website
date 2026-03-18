{
  description = "abels website";

  inputs = {
    fenix.url = "github:nix-community/fenix/f2eb76a4605b0f055e2a9eac47fe1797f19d21c1";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    fenix,
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem = {
        pkgs,
        system,
        ...
      }: let
        rustPkg = with fenix.packages.${system};
          combine [
            targets.wasm32-unknown-unknown.latest.rust-std
            (latest.withComponents
              [
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
      in {
        devShells.default = with pkgs;
          mkShell {
            nativeBuildInputs = [
              rustPkg
              wasm-pack
              nodejs
              libgcc.lib
            ];
          };
      };
    };
}

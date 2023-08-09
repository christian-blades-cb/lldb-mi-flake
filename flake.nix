{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    lldb-mi-src = {
      flake = false;
      url = "github:lldb-tools/lldb-mi";
    };
  };

  outputs = inputs@{ nixpkgs, flake-utils, lldb-mi-src, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          packages.default = pkgs.stdenv.mkDerivation ( rec {
            pname = "lldb-mi";
            version = "0.0.1";

            src = lldb-mi-src;

            nativeBuildInputs = [ pkgs.cmake ];
            buildInputs = [
              pkgs.llvm_15
              pkgs.llvmPackages_15.lldb
            ];
          });
        }
    );
}

with import <nixpkgs> {};

#{ stdenv, clangStdenv, nix, cmake, pkgconfig }:
 
let nixVersion = (builtins.parseDrvName nix.name).version;
in clangStdenv.mkDerivation {
  name = "nix-repl-0.1.1";
  buildInputs = [ nix pkgconfig cmake readline boehmgc sourceHighlight ];
  src = ./.;
  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Debug"
    "-DSOURCE_HIGHLIGHT_PREFIX=${sourceHighlight}"
  ];
  CXXFLAGS = "-DNIX_VERSION=\"${nixVersion}\"";
}

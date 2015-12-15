{ nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

with import nixpkgs { inherit system; };

let nix = nixUnstable;
in
runCommand "nix-repl-0.1.0" { buildInputs = [ readline nix boehmgc ]; } ''
    mkdir -p $out/bin
    g++ -O3 -Wall -std=c++0x                                               \
      -o $out/bin/nix-repl ${./src/nix-repl.cc}                            \
      -I${nix}/include/nix                                                 \
      -lnixformat -lnixutil -lnixstore -lnixexpr -lnixmain -lreadline -lgc \
      -DNIX_VERSION=\"${(builtins.parseDrvName nix.name).version}\"
''

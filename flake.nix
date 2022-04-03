{
  description = "Le site web de Paul Valensier. Oui, *THE* Paul Valensier";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    flake-compat = { url = github:edolstra/flake-compat; flake = false; };
    node-deps = { url = path:./node-deps; flake = false; };
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat, node-deps }: 
    let 
      forSystem = system: 
        let 
          pkgs = nixpkgs.legacyPackages.${system};
          nodeDependencies = (import node-deps { inherit pkgs; }).shell.nodeDependencies;
        in 
          rec {
            devShell =
              pkgs.mkShell {
                buildInputs = [ pkgs.nodejs-12_x pkgs.nodePackages.node2nix ];
              };
            
            defaultPackage = 
              pkgs.stdenv.mkDerivation {
                name = "paulvalensier.github.io-${self.shortRev or "dirty"}";
                
                buildInputs = [ pkgs.nodejs-12_x ];

                src = ./.;

                installPhase = ''
                  ln -s ${nodeDependencies}/lib/node_modules ./node_modules
                  export PATH="${nodeDependencies}/bin:$PATH"
                  mkdir -p $out

                  eleventy --output=$out
                '';
              };
          };
    in flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] forSystem;
}

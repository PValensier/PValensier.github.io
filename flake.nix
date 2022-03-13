{
  description = "Le site web de Paul Valensier. Oui, *THE* Paul Valensier";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils }: 
    let 
      forSystem = system: 
        let 
          pkgs = nixpkgs.legacyPackages.${system};
        in 
          {
            devShell.x86_64-darwin =
              pkgs.mkShell {
                buildInputs = [ pkgs.nodejs ];
              };
          };
    in
      flake-utils.lib.eachDefaultSystem forSystem;
}

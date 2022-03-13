{
  description = "Le site web de Paul Valensier. Oui, *THE* Paul Valensier";

  inputs = {
    nixpkgs.url = github:NixOS/nixkpgs/nixos-21.11;
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

  };
}

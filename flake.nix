{
  description = "A flake for Neurivizr Firmware updater";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, ... }: 
  
  {

    packages.x86_64-linux.nvupdater = nixpkgs.legacyPackages.x86_64-linux.callPackage ./nvupdater.nix {};

    packages.x86_64-linux.default = self.packages.x86_64-linux.nvupdater;

  };
}

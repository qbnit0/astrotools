{
  description = "Computing environment for astronomy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = pkgs.lib;
    python = pkgs.python312;
  in {

    environments.${system} = {
      python = python.withPackages(pythonPackages: with pythonPackages; [
        numpy
        scipy
        matplotlib
        pandas
        pint
        astropy
        sympy
        jupyter
      ]);
    };

    packages.${system}.default = pkgs.buildEnv {
      name = "science";
      paths = builtins.attrValues self.environments.${system};
    };

  };
}

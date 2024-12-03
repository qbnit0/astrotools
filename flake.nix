{
  description = "Computing environment for astronomy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }: let
    withSystem = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix;
    pythonPackageName = "python312";
  in {

    environments = withSystem(system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
      python = builtins.getAttr pythonPackageName pkgs;
    in {
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
    });

    packages = withSystem(system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
      python = builtins.getAttr pythonPackageName pkgs;
    in {
      default = pkgs.buildEnv {
        name = "astronomy";
        paths = builtins.attrValues self.environments.${system};
      };
    });

  };
}

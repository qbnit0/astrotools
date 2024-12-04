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
      python = python.withPackages(pythonPackagesOriginal: let
        pythonPackages = lib.fix (lib.extends (import ./pkgs/python { inherit pkgs; }) (_: pythonPackagesOriginal));
      in with pythonPackages; [
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
      fromEnv = ships: runs: pkgs.runCommand runs {} ''
        mkdir -p $out/bin
        cp ${self.packages.${system}.default}/bin/${ships} $out/bin
      '';
    in {
      default = pkgs.buildEnv {
        name = "astronomy";
        paths = builtins.attrValues self.environments.${system};
      };

      python = fromEnv "python" "python";
      jupyter-lab = fromEnv "jupyter-lab" "jupyter-lab";
      jupyter-notebook = fromEnv "jupyter-notebook" "jupyter-notebook";
      jupyter = fromEnv "jupyter*" "jupyter";
    });

  };
}

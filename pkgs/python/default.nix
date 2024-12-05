{ pkgs, ... }:
final: prev: {
  ccdproc = prev.buildPythonPackage rec {
    pname = "ccdproc";
    version = "2.4.2";
    src = pkgs.fetchFromGitHub {
      owner = "astropy";
      repo = "ccdproc";
      rev = version;
      hash = "sha256-wsxES+Y07ZZurrG6Ty0RO9igHcUL8XH1CclGNLlPHwQ=";
    };
    pyproject = true;
    build-system = with final; [
      setuptools
      setuptools-scm
    ];
    dependencies = with final; [
      numpy
      astropy
      scipy
      reproject
      scikit-image
      astroscrappy
    ];
  };
  astroscrappy = prev.buildPythonPackage rec {
    pname = "astroscrappy";
    version = "1.2.0";
    src = pkgs.fetchFromGitHub {
      owner = "astropy";
      repo = "astroscrappy";
      rev = "v${version}";
      hash = "sha256-AkOfqdTrKGPaS3nagJxzXNjIv2Ss0JMhmgo29O0itZ8=";
    };
    pyproject = true;
    build-system = with final; [
      setuptools
      setuptools-scm
      numpy_2
      extension-helpers
      cython
    ];
    dependencies = with final; [
      numpy
      astropy
    ];
  };
  astroalign = prev.buildPythonPackage rec {
    pname = "astroalign";
    version = "2.6.1";
    src = pkgs.fetchFromGitHub {
      owner = "quatrope";
      repo = "astroalign";
      rev = "v${version}";
      hash = "sha256-ibFu2hIc7N937Tn3zXpBn8sm92Vcb43YIHm/0SWwxeQ=";
    };
    pyproject = true;
    build-system = with final; [
      setuptools
      setuptools-scm
    ];
    dependencies = with final; [
      numpy
      scipy
      scikit-image
      sep-pjw
    ];
  };
  sep-pjw = prev.buildPythonPackage rec {
    pname = "sep-pjw";
    version = "1.3.7";
    src = pkgs.fetchFromGitHub {
      owner = "pj-watson";
      repo = "sep-pjw";
      rev = "v${version}";
      hash = "sha256-3MCEwHRxRbcNaVt8FYNY9OkfAstFt2WCFGjYqY5tGgE=";
    };
    pyproject = true;
    build-system = with final; [
      setuptools
      setuptools-scm
      wheel
      numpy_2
      cython
    ];
    dependencies = with final; [
      numpy
    ];
  };
}

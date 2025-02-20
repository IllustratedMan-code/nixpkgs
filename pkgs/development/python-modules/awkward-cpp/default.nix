{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, cmake
, numpy
, pybind11
, scikit-build-core
, typing-extensions
}:

buildPythonPackage rec {
  pname = "awkward-cpp";
  version = "5";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-5dapDZihTas2WYAV5pJDufg7iFFVYQTL53jKnHmSNlY=";
  };

  nativeBuildInputs = [
    cmake
    pybind11
    scikit-build-core
  ] ++ scikit-build-core.optional-dependencies.pyproject;

  propagatedBuildInputs = [
    numpy
  ];

  dontUseCmakeConfigure = true;

  pythonImportsCheck = [
    "awkward_cpp"
  ];

  meta = with lib; {
    description = "CPU kernels and compiled extensions for Awkward Array";
    homepage = "https://github.com/scikit-hep/awkward";
    license = licenses.bsd3;
    maintainers = with maintainers; [ veprbl ];
  };
}

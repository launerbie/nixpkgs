{ fetchurl, buildPythonPackage, isPy33, lib, six, pythonAtLeast, pythonOlder }:

buildPythonPackage rec {
  version = "3.2.5";
  pname = "nltk";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://pypi/n/nltk/nltk-${version}.tar.gz";
    sha256 = "2661f9971d983db314bbebd51ba770811a362c6597fd0f303bb1d3beadcb4834";
  };

  propagatedBuildInputs = [ six ];

  disabled = pythonOlder "2.7" || pythonOlder "3.4" && (pythonAtLeast "3.0");

  # Tests require some data, the downloading of which is impure. It would
  # probably make sense to make the data another derivation, but then feeding
  # that into the tests (given that we need nltk itself to download the data,
  # unless there's an easy way to download it without nltk's downloader) might
  # be complicated. For now let's just disable the tests and hope for the
  # best.
  doCheck = false;

  meta = {
    description = "Natural Language Processing ToolKit";
    homepage = http://nltk.org/;
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ lheckemann ];
  };
}

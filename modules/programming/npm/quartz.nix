{ lib, buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "quartz";
  version = "4.0.8";

  src = fetchFromGitHub {
    owner = "jackyzha0";
    repo = pname;
    rev = "v${version}";
    hash = "";
  };

  meta = with lib; {
    description = "Quartz is a set of tools that helps you publish your digital garden and notes as a website for free. Quartz v4 features a from-the-ground rewrite focusing on end-user extensibility and ease-of-use.";
    homepage = "https://quartz.jzhao.xyz/";
    license = license.mit;
  };

}


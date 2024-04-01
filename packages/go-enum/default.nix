{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "go-enum";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "abice";
    repo = "go-enum";
    rev = "v${version}";
    hash = "sha256-Mt45Qz8l++bvBLKEpbX0m8iTkHDpsZtdYhhHUprQKY8=";
  };

  vendorHash = "sha256-YzIVI+PLZt24s/KjTxifWrvjrIU8jLvkC1lgw4yG6cg=";

  ldflags = [ "-s" "-w" ];

  meta = with lib; {
    description = "An enum generator for go";
    homepage = "https://github.com/abice/go-enum";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "go-enum";
  };
}

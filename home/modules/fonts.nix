{ pkgs, ... }:

let
  bizter-font = pkgs.stdenvNoCC.mkDerivation {
    pname = "bizter-font";
    version = "0.0.2";

    src = pkgs.fetchFromGitHub {
      owner = "yuru7";
      repo = "BIZTER";
      rev = "v0.0.2";
      hash = "sha256-uIb3F2F3ITQ7X5ftocWgOVXzyKQ9hP/kgWhvvd64C6w=";
    };

    nativeBuildInputs = [
      (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
        fontforge
        ttfautohint-py
      ]))
    ];

    buildPhase = ''
      runHook preBuild
      python build.py
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      install -Dm644 build_tmp/*.ttf -t $out/share/fonts/bizter
      runHook postInstall
    '';
  };
in

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    bizter-font
    hackgen-font
  ];
}

{ lib
, stdenv
, fetchFromGitHub
, qt5
, p7zip
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "skyscraper";
  version = "3.12.0";

  src = fetchFromGitHub {
    owner = "Gemba";
    repo = "skyscraper";
    rev = "refs/tags/${finalAttrs.version}";
    hash = "sha256-KmRow3Cw34Y/UBFEmjUSPMqb4O49DAcfCMu7qVSrtKw=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    qt5.wrapQtAppsHook
    qt5.qmake
  ];

  path = lib.makeBinPath [ p7zip ];

  env.PREFIX = placeholder "out";

  meta = {
    description = "Powerful and versatile game data scraper written in Qt and C++";
    homepage = "https://gemba.github.io/skyscraper/";
    downloadPage = "https://github.com/Gemba/skyscraper/releases/tag/${finalAttrs.version}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ashgoldofficial ];
    mainProgram = "Skyscraper";
    platforms = lib.platforms.linux;
  };
})

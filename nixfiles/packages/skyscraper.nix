{ lib
, stdenv
, fetchFromGitHub
, qt5
, p7zip
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "skyscraper";
  # version = "3.11.1";
  version = "3.12";

  src = fetchFromGitHub {
    owner = "Gemba";
    repo = "skyscraper";
    # rev = "refs/tags/${finalAttrs.version}";
    rev = "refs/heads/master";
    # hash = "sha256-tGKztGkDG6nmq4aoOkQ4XVOcnL1NdZJ0zNUe0lUPlZ4=";
    hash = "sha256-q4q2/8KAII16RMksQpWivVnWAdd8qrKM5XN/CV0T9m8=";
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

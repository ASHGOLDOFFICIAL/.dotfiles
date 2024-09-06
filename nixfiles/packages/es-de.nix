{ lib
, SDL2
, alsa-lib
, cmake
, fetchFromGitLab
, ffmpeg
, freeimage
, freetype
, harfbuzz
, icu
, libgit2
, pkg-config
, poppler
, gettext
, pugixml
, stdenv
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "es-de";
  version = "3.0.3";

  src = fetchFromGitLab {
    owner = "es-de";
    repo = "emulationstation-de";
    rev = "v${finalAttrs.version}";
    hash = "sha256-w/Kz9Hox5/Ed8n/e2qUF3tfm+a0YNTK1hC1hDp3Xa9w=";
  };

  outputs = [ "out" "man" ];

  strictDeps = true;

  patches = [
    ./001-add-nixpkgs-retroarch-cores-unix.patch
    ./002-add-nixpkgs-retroarch-cores-linux.patch
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    gettext
  ];

  buildInputs = [
    SDL2
    alsa-lib
    ffmpeg
    freeimage
    freetype
    gettext
    harfbuzz
    icu
    libgit2
    poppler
    pugixml
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    
    # By default the application updater will be built
    # which checks for new releases on startup, this disables it.
    "-DAPPLICATION_UPDATER=off"
  ];

  meta = {
    description = "Frontend for browsing and launching games from your multi-platform collection.";
    homepage = "https://es-de.org";
    downloadPage = "https://es-de.org/#Download";
    changelog = "https://gitlab.com/es-de/emulationstation-de/-/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ashgoldofficial ivarmedi ];
    mainProgram = "es-de";
    platforms = lib.platforms.linux;
  };
})

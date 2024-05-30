{ lib
, stdenv
, fetchFromGitHub
, cmake
, SDL2
, openal
, glew
, freeglut
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "openjkdf2";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "shinyquagsire23";
    repo = "OpenJKDF2";
    rev = "v${finalAttrs.version}";
    hash = "sha256-M3Pr0P1wAwP26mROD9ZKf1Ox9DWNLCkW2n5Bapw6Ovo=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    openal
    glew
    freeglut
    SDL2
  ];

  installPhase = let
    installIcon = resolution: ''
      install -TDm 644 ./packaging/flatpak/icons/${resolution}.png \
        $out/share/icons/hicolor/${resolution}x${resolution}/apps/org.openjkdf2.OpenJKDF2.png
    '';
    iconInstallation = (lib.concatMapStringsSep "\n" installIcon [
      "16" "24" "32" "48" "64" "96" "128" "192" "256" "384" "512"
    ]);
  in ''
    runHook preInstall

    install -Dm 644 ./packaging/flatpak/org.openjkdf2.OpenJKDF2.desktop \
      -t $out/share/applications/
    ${iconInstallation}

    runHook postInstall
  '';

  meta = {
    description = "A cross-platform reimplementation of JKDF2 in C";
    longDescription = ''
      Open-source re-implementation of “Jedi Knight: Dark Forces II” (JKDF2).
    '';
    homepage = "https://github.com/shinyquagsire23/OpenJKDF2";
    downloadPage = "https://github.com/shinyquagsire23/OpenJKDF2/releases";
    changelog = "https://github.com/shinyquagsire23/OpenJKDF2/releases/tag/v${finalAttrs.version}";
    # TODO: It uses modified form of bsd0
    license = lib.licenses.bsd0;
    maintainers = with lib.maintainers; [];
    mainProgram = "openjkdf2";
    platforms = lib.platforms.linux;
  };
})

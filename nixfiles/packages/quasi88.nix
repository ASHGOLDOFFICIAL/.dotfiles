{ lib
# , SDL2
, libX11
, libXext
, fetchFromGitHub
, stdenv
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "quasi88";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "RetroAchievements";
    repo = "quasi88";
    rev = "refs/tags/RAQuasi88.${finalAttrs.version}";
    hash = "sha256-Zvrymu/kV0ALuIRaYFArgUhR9MGnyQn3nZq/981PWzU=";
  };

  outputs = [ "out" "man" ];

  strictDeps = true;

  nativeBuildInputs = [
    libX11
    libXext
  ];
  
  buildInputs = [
    libX11
    libXext
  ];

  meta = {
    description = "";
    homepage = "https://www.eonet.ne.jp/~showtime/quasi88/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ashgoldofficial ];
    mainProgram = "quasi88";
    platforms = lib.platforms.linux;
  };
})

{ lib
, stdenv
, fetchsvn
, cmake
, libX11
, libXxf86vm
, libXext
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "thedarkmod";
  version = "2.12";

  src = fetchsvn {
    url = "https://svn.thedarkmod.com/publicsvn/darkmod_src/tags/2.12";
    rev = "10746";
    hash = "sha256-jPQWoLlsUQqpBB1BECR9m/p+HwD0jJlpqwUaIqygwP0=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    libX11
    libXxf86vm
    libXext
  ];

  buildInputs = [
    libX11
    libXxf86vm
    libXext
  ];

  meta = {
    description = "Free first person stealth game inspired";
    homepage = "https://www.thedarkmod.com/main/";
    downloadPage = "https://www.thedarkmod.com/downloads/";
    licenses = with lib.licenses; [ bsd3 gpl3only cc-by-nc-sa-30 ];
    maintainers = with lib.maintainers; [ ashgoldofficial ];
    mainProgram = "thedarkmod";
    platforms = lib.platforms.linux;
  };
})

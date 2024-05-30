{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "thunderbird-gnome-theme";
  version = "115";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "thunderbird-gnome-theme";
    rev = "main";
    hash = "sha256-nQBz2PW3YF3+RTflPzDoAcs6vH1PTozESIYUGAwvSdA=";
  };

  outputs = [ "out" "doc" ];

  strictDeps = true;

  installPhase = ''
    runHook preInstall

    install -d $out
    cp -ra ./configuration ./theme ./icon.svg ./userChrome.css ./userContent.css -t $out
    install -Dm 644 ./README.md -t $doc/share/doc/firefox-gnome-theme/

    runHook postInstall
  '';

  meta = {
    description = "A GNOME theme for Thunderbird";
    longDescription = ''
      A GNOME theme for Thunderbird
      This theme follows latest GNOME Adwaita style.
      This theme is a work in progress.
    '';
    homepage = "https://github.com/rafaelmardojai/thunderbird-gnome-theme";
    license = lib.licenses.unlicense;
    maintainers = with lib.maintainers; [ ashgoldofficial ];
    platforms = lib.platforms.all;
  };
})

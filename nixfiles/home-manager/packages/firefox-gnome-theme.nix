{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation (finalAttrs: {
  pname = "firefox-gnome-theme";
  version = "132";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = "refs/tags/v${finalAttrs.version}";
    hash = "sha256-lf9MQs8+NUvQd8b5t+7c4kLqUQixGO9WwWcLa1XYuiQ=";
  };

  outputs = [ "out" "doc" ];

  strictDeps = true;
  dontBuild = true;

  # Only copy necessary files
  installPhase = ''
    runHook preInstall

    install -d $out
    cp -ra ./configuration ./theme ./icon.svg ./userChrome.css ./userContent.css -t $out
    install -Dm 644 ./README.md -t $doc/share/doc/firefox-gnome-theme/

    runHook postInstall
  '';

  meta = {
    description = "A GNOME theme for Firefox";
    longDescription = ''
      A GNOME theme for Firefox.
      This theme follows latest GNOME Adwaita style.
    '';
    homepage = "https://github.com/rafaelmardojai/firefox-gnome-theme";
    downloadPage =
      "https://github.com/rafaelmardojai/firefox-gnome-theme/releases";
    license = lib.licenses.unlicense;
    maintainers = with lib.maintainers; [ ashgoldofficial ];
    platforms = lib.platforms.all;
  };
})

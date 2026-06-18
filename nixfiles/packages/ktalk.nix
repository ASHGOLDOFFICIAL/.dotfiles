{
  lib,
  appimageTools,
  fetchurl,
  ...
}:

let
  version = "3.4.0";
  pname = "ktalk";

  src = fetchurl {
    url = "https://st.ktalk.host/ktalk-app/linux/ktalk${version}x86_64.AppImage";
    hash = "sha256-qSk1obVCLcNRnGGfeMO+H+frJkHu8EicQayZXaPMboY=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
  appimageTools.wrapType2 rec {
    inherit pname version src;

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${appimageContents}/usr/share/icons $out/share
    '';

    meta = {
      description = "Meeting app";
      homepage = "https://kontur.ru/talk";
      downloadPage = "https://app.ktalk.ru/download/app";
      license = lib.licenses.unfree;
      sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
      maintainers = with lib.maintainers; [ ashgoldofficial ];
      platforms = [ "x86_64-linux" ];
    };
  }

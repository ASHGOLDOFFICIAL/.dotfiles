{ lib
, mkYarnPackage
, fetchFromGitHub
, makeDesktopItem
, imagemagick
, nodejs
, yarn
}:

mkYarnPackage rec {
  pname = "gb-studio";
  version = "3.2.1";

  src = fetchFromGitHub {
    owner = "chrismaltby";
    repo = "gb-studio";
    rev = "refs/tags/v${version}";
    hash = "sha256-hF8aDTg7v9p0d9AUE2NNhQACgggMEbi5afzK1GqUHx0=";
  };

  strictDeps = true;

  # doDist = false;

  nativeBuildInputs = [
    imagemagick
    nodejs
    yarn
  ];

  yarnPostBuild = let
    desktopItem = makeDesktopItem {
      name = pname;
      desktopName = "GB Studio";
      comment = "Visual retro game maker";
      genericName = "GB Studio";
      exec = "${meta.mainProgram} %U";
      icon = pname;
      type = "Application";
      startupNotify = true;
      categories = [ "Development" "Building" "IDE" ];
    };
  in ''
    ls -la v8*
    pushd ./deps/gb-studio
    for size in 64 128 256 512 1024; do
      mkdir -p $out/share/icons/hicolor/"$size"x"$size"/
      convert -resize "$size"x"$size" ./src/assets/app/icon/app_icon.png \
         $out/share/icons/hicolor/"$size"x"$size"/${pname}.png
    done
    popd

    install -Dm 644 ${desktopItem}/share/applications/*.desktop \
      -t $out/share/applications
  '';

  meta = {
    description = "A quick and easy to use drag and drop retro game creator for your favourite handheld video game system";
    homepage = "https://www.gbstudio.dev/";
    downloadPage = "https://chrismaltby.itch.io/gb-studio";
    changelog = "https://github.com/chrismaltby/gb-studio/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ashgoldofficial musjj ];
    mainProgram = pname;
    platforms = lib.platforms.linux;
  };
}

{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "zapret";
  version = "70";

  src = fetchFromGitHub {
    owner = "bol-van";
    repo = "zapret";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ywqJ44WN0UmZEVUlghuBDSdeaBpf7F8KjrcKSwx/ATI=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -rt $out/bin/ $src/files/*
    runHook postInstall
  '';
})
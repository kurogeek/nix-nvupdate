{ lib
, stdenv
, writeShellScriptBin
, fetchurl
, symlinkJoin
, esptool
}:
let
  nvupdater = stdenv.mkDerivation rec {
    name = "nvupdate";
    version = "1.0.0";

    # src = ./nvupdate-nix;
    src = fetchurl {
      url = "https://dev.eyekandi.asia/static/fw/nvupdate-linux";
      sha256 = "0mw0q2ws487jircyslpqrnkvxv25qcrly1z7b72qajx88g9sgnmv";
    };

    dontConfigure = true;
    dontBuild = true;
    dontUnpack = true;
    
    # unpackPhase = ":";

    installPhase = ''
      mkdir -p $out/bin
      install -m 755 $src $out/bin/nvupdate
      
    '';
  };

  runScript = writeShellScriptBin nvupdater.name ''
    PATH=$PATH:${esptool}/bin/
    export NIXOS=1
    ${nvupdater}/bin/nvupdate
  '';
in
symlinkJoin {
  name = nvupdater.name;
  paths = [runScript];
}
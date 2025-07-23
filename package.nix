{
  lib,
  SDL2,
  libGL,
  libzip,
  stdenv,
  pkg-config,
  SDL2_image,
  SDL2_mixer,
  lua5_4_compat,
  fetchFromGitHub,
}: let
  version = "1.4.5";
in
  stdenv.mkDerivation {
    pname = "pekka-kana-2";
    inherit version;

    src = fetchFromGitHub {
      owner = "danilolc";
      repo = "pk2";
      rev = version;
      sha256 = "sha256-WSxx6fV1grTvo4L2YdJRVYz3fhebgJxhtTS5Xp/Takg=";
    };

    enableParallelBuilding = true;

    nativeBuildInputs = [pkg-config];

    buildInputs = [
      SDL2
      libGL
      libzip
      SDL2_image
      SDL2_mixer
      lua5_4_compat
    ];

    env.NIX_CFLAGS_COMPILE = "
      -I${lib.getDev SDL2}/include/SDL2
      -I${lib.getDev SDL2_image}/include/SDL2
      -I${lib.getDev SDL2_mixer}/include/SDL2
    ";

    installPhase = ''
      mkdir -p $out/bin
      cp bin/pekka-kana-2 $out/bin

      mkdir -p $out
      cp -r res $out
    '';

    meta = {
      description = "A jump 'n run game made in the spirit of classic platformers.";
      homepage = "https://github.com/danilolc/pk2";
      license = lib.licenses.mit;
      platforms = ["x86_64-linux"];
      mainProgram = "pekka-kana-2";
    };
  }

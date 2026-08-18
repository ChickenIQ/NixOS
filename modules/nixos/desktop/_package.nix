{
  stdenv,
  fetchurl,
  meson,
  ninja,
  pkg-config,
  python3,
  patchelf,
  fftw,
  fftwFloat,
  libsamplerate,
  openblas,
  ladspa-sdk,
}:
stdenv.mkDerivation rec {
  pname = "khip";
  version = "0.4";

  src = fetchurl {
    url = "https://codeberg.org/khip/khip/releases/download/v${version}/khip-${version}.tar.gz";
    hash = "sha256-h4FdFMkunHTRHF1Nsr4T2jAP8eJejf6OH+osBgvJze0=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3
    patchelf
  ];

  buildInputs = [
    fftw
    fftwFloat
    libsamplerate
    openblas
    ladspa-sdk
  ];

  postPatch = "cp ${
    fetchurl {
      url = "https://cdn.discordapp.com/assets/krisp_browser_models/v1.0.11_1/model_32.kw";
      hash = "sha256-TEldeJycd1BppD3q3XPgtuRgy1XuKr4sJbtdyq9/KNU=";
    }
  } model_32.kw";

  postFixup = ''patchelf --add-rpath "$out/lib" "$out/lib/ladspa/libkhip_ladspa.so"'';
}

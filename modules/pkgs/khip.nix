{
  perSystem =
    { pkgs, ... }:
    let
      model = pkgs.fetchurl {
        url = "https://cdn.discordapp.com/assets/krisp_browser_models/v1.0.11_1/model_32.kw";
        hash = "sha256-TEldeJycd1BppD3q3XPgtuRgy1XuKr4sJbtdyq9/KNU=";
      };
    in
    {
      packages.khip = pkgs.stdenv.mkDerivation rec {
        pname = "khip";
        version = "0.4";

        src = pkgs.fetchurl {
          url = "https://codeberg.org/khip/khip/releases/download/v${version}/khip-${version}.tar.gz";
          hash = "sha256-h4FdFMkunHTRHF1Nsr4T2jAP8eJejf6OH+osBgvJze0=";
        };

        ninjaFlags = [ "libkhip_ladspa.so" ];

        nativeBuildInputs = with pkgs; [
          pkg-config
          python3
          meson
          ninja
        ];

        buildInputs = with pkgs; [
          libsamplerate
          ladspa-sdk
          fftwFloat
          openblas
        ];

        postPatch = ''
          cp ${model} model_32.kw
          substituteInPlace meson.build --replace-fail "khip = shared_library(" "khip = static_library("
          substituteInPlace khip_ladspa.c --replace-fail "      khip_ladspa->input_buf_len = 0;" "      float *out = khip_ladspa->output_buf + khip_ladspa->output_buf_len;
              for (size_t ix = 0; ix < KHIP_BUF_SIZE; ix++) {
                if (!isfinite(out[ix])) {
                  memset(out, 0, sizeof(float) * KHIP_BUF_SIZE);
                  khip_reset(khip_ladspa->khip);
                  break;
                }
              }
              khip_ladspa->input_buf_len = 0;"
        '';

        installPhase = ''
          runHook preInstall
          install -Dm755 libkhip_ladspa.so "$out/lib/ladspa/libkhip_ladspa.so"
          runHook postInstall
        '';
      };
    };
}

{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  gcc-unwrapped,          # 提供 libatomic.so.1
  makeWrapper,
  android-tools,
  git,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "maa-cli";
  version = "0.7.5";

  src = fetchFromGitHub {
    owner = "MaaAssistantArknights";
    repo = "maa-cli";
    rev = "v${finalAttrs.version}";
    hash = "sha256-rvFjtmsOC25t/vKgZGO6WmwtC+yxXoZKXvwd3jpoKvY=";
  };

  cargoHash = "sha256-HQTur+MJLu25auR7+EiFfHoqWOlmDN+EDKI4PJe7wnE=";

  doCheck = false;

  nativeBuildInputs = [
    pkg-config
    makeWrapper
  ];
  buildInputs = [ openssl ];

  postInstall = ''
    wrapProgram $out/bin/maa \
      --set LD_LIBRARY_PATH "${gcc-unwrapped.lib}/lib" \
      --prefix PATH : "${lib.makeBinPath [ android-tools git ]}"
  '';

  meta = {
    description = "Simple CLI for MAA by Rust";
    homepage = "https://github.com/MaaAssistantArknights/maa-cli";
    license = lib.licenses.agpl3Only;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    maintainers = [];
    mainProgram = "maa";
  };
})
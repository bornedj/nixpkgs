{
  lib,
  stdenv,
  cmake,
  fetchFromGitHub,
  hwdata,
  hyprutils,
  hyprwayland-scanner,
  libdisplay-info,
  libdrm,
  libffi,
  libGL,
  libinput,
  mesa,
  nix-update-script,
  pixman,
  pkg-config,
  seatd,
  udev,
  wayland,
  wayland-protocols,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "aquamarine";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "hyprwm";
    repo = "aquamarine";
    rev = "v${finalAttrs.version}";
    hash = "sha256-1RYuBS/CQhtyIeXrLDvGWJhuVG1kiQMG+aYaBkoGnEU=";
  };

  nativeBuildInputs = [
    cmake
    hyprwayland-scanner
    pkg-config
  ];

  buildInputs = [
    hwdata
    hyprutils
    libdisplay-info
    libdrm
    libffi
    libGL
    libinput
    mesa
    pixman
    seatd
    udev
    wayland
    wayland-protocols
  ];

  strictDeps = true;

  outputs = [
    "out"
    "dev"
  ];

  cmakeBuildType = "RelWithDebInfo";

  passthru.updateScript = nix-update-script { };

  meta = {
    changelog = "https://github.com/hyprwm/aquamarine/releases/tag/${finalAttrs.version}";
    description = "A very light linux rendering backend library";
    homepage = "https://github.com/hyprwm/aquamarine";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [
      fufexan
      johnrtitor
    ];
    platforms = lib.platforms.linux ++ lib.platforms.freebsd;
  };
})

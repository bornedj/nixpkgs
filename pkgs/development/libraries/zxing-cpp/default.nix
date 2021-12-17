{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, cmake
}:

stdenv.mkDerivation rec {
  pname = "zxing-cpp";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "nu-book";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-N2FTzsjxm3EE5Wqz7xt+FS4zQ60Ow4WbdX6Eo08ktek=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  # error: 'path' is unavailable: introduced in macOS 10.15
  CXXFLAGS = lib.optional (stdenv.hostPlatform.system == "x86_64-darwin") "-D_LIBCPP_DISABLE_AVAILABILITY";

  cmakeFlags = [
    "-DBUILD_EXAMPLES=OFF"
  ];

  meta = with lib; {
    homepage = "https://github.com/nu-book/zxing-cpp";
    description = "C++ port of zxing (a Java barcode image processing library)";
    longDescription = ''
      ZXing-C++ ("zebra crossing") is an open-source, multi-format 1D/2D barcode
      image processing library implemented in C++.

      It was originally ported from the Java ZXing Library but has been
      developed further and now includes many improvements in terms of quality
      and performance. It can both read and write barcodes in a number of
      formats.
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ AndersonTorres ];
    platforms = with platforms; unix;
  };
}

{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname    = "z-library";
  version  = "2.4.2";

  src = pkgs.fetchgit {
    url    = "https://aur.archlinux.org/z-library-bin.git";
    rev    = "5d4e0a77670878c2faf112591061f035b68dc72c";    # <-- your commit
    sha256 = "1pkhq2j5ia6948z95f1mfxqrc04siiviv6lnn0v1n5bf7v40phrw ";                      # <-- what nix-prefetch-git printed
  };

  nativeBuildInputs = [ pkgs.binutils pkgs.makeWrapper ];
  buildPhase = "";

  installPhase = ''
    mkdir -p "$out" "$out/bin"

    cd "$src"
    curl -L -o "zlibrary-setup-latest_${version}.deb" \
      "https://s3proxy.cdn-zlib.sk/te_public_files/soft/linux/zlibrary-setup-latest.deb"

    ar x "zlibrary-setup-latest_${version}.deb"
    tar -xf data.tar.xz -C "$out"

    exe="$out/usr/lib/z-library/z-library"
    chmod +x "$exe"
    wrapProgram "$exe" --prefix LD_LIBRARY_PATH ":" "$out/usr/lib/z-library"
    ln -s "$exe" "$out/bin/z-library"
  '';

  meta = with pkgs.lib; {
    description = "Z-Library (binary) extracted from AUR z-library-bin .deb";
    homepage    = "https://aur.archlinux.org/packages/z-library-bin";
    license     = licenses.isc;
    platforms   = [ "x86_64-linux" ];
  };
}


{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname    = "z-library";
  version  = "2.4.2";

  ##################################################################
  ## 1) Fetch the AUR git repo (we only need it for the PKGBUILD).
  ##
  ##    The upstream PKGBUILD shows that:
  ##      - It downloads "zlibrary-setup-latest_${pkgver}.deb"
  ##      - It unpacks it with `ar p … data.tar.xz | tar xJ`
  ##      - It copies "usr" and "opt" into $pkgdir, then symlinks
  ##        "/usr/bin/z-library" → "../../opt/Z-Library/z-library".
  ##
  src = pkgs.fetchgit {
    url    = "https://aur.archlinux.org/z-library-bin.git";
    rev    = "5d4e0a77670878c2faf112591061f035b68dc72c";    # ← (your commit hash)
    sha256 = "1pkhq2j5ia6948z95f1mfxqrc04siiviv6lnn0v1n5bf7v40phrw";
    #   ↑ replace with the Base-32 sha256 you got from `nix-prefetch-git`
  };

  ##################################################################
  ## 2) At evaluation time, fetch the Debian package so the build
  ##    phase never needs to hit the network.  The AUR PKGBUILD's
  ##    "source" is:
  ##      zlibrary-setup-latest_${pkgver}.deb::https://…/zlibrary-setup-latest.deb
  ##
  deb = pkgs.fetchurl {
    url = "https://s3proxy.cdn-zlib.sk/te_public_files/soft/linux/zlibrary-setup-latest.deb";
    sha256 = "1dic1r5pmvgihiffksq4jkzjs6ffrd36ly1dz156q02lsljhcb1v";
    #   ↑ replace with the Base-32 sha256 from `nix-prefetch-url`
  };

  ##################################################################
  ## 3) We only need `ar` (binutils) to unpack the .deb.  We don’t
  ##    compile anything, so we skip `curl`, `npm`, etc.
  ##
  nativeBuildInputs = [
    pkgs.binutils    # provides `ar`
    pkgs.makeWrapper # in case we ever want to wrap the binary
  ];

  ##################################################################
  ## 4) There is no actual "build" step – AUR’s PKGBUILD just unpacks
  ##    the .deb.  So we override buildPhase to be a no-op.
  ##
  buildPhase = "";

  ##################################################################
  ## 5) In installPhase, we:
  ##      a) Create $out              (the final Nix store path)
  ##      b) `ar x <deb>` to extract data.tar.xz
  ##      c) `tar xJf data.tar.xz` in a temporary dir (we use `$TMPDIR`)
  ##         → This will produce exactly two top-level folders:
  ##           • `opt/Z-Library/`        (Electron app + shell script)
  ##           • `usr/...`               (desktop files, icons, MIME, etc.)
  ##      d) Copy those two folders into `$out`
  ##      e) Create a symlink `$out/bin/z-library` → `$out/opt/Z-Library/z-library`
  ##
  installPhase = ''
    # 5a) Create $out with the directories we need
    mkdir -p "$out/opt" "$out/usr" "$out/bin"

    # 5b) Unpack the Debian archive into a temp dir
    mkdir temp-deb-unpack
    cd temp-deb-unpack
    ar x "${deb}"             # extracts control.tar.gz, data.tar.xz, etc.

    # 5c) The .deb’s data.tar.xz contains:
    #       ./opt/Z-Library/…
    #       ./usr/share/applications/…
    #       ./usr/share/icons/hicolor/…
    #       ./usr/share/mime/…
    #     We extract *only* the data.tar.xz into our temp dir:
    tar -xf data.tar.xz

    # 5d) Copy `opt/` and `usr/` into $out:
    #     (we preserve the directory structure exactly as the AUR PKGBUILD does)
    cp -r opt "$out/"
    cp -r usr "$out/"

    # 5e) Create a symlink so that `z-library` is on the user’s $PATH:
    #     /usr/bin/z-library → ../../opt/Z-Library/z-library
    ln -s "$out/opt/Z-Library/z-library" "$out/bin/z-library"
  '';

  ##################################################################
  ## 6) Metadata (match the upstream AUR PKGBUILD)
  ##
  meta = with pkgs.lib; {
    description = "Z-Library (Electron-based reader), extracted from the official .deb";
    homepage    = "https://aur.archlinux.org/packages/z-library-bin";
    license     = licenses.isc;       # upstream PKGBUILD: ISC
    maintainers = [ ];
    platforms   = [ "x86_64-linux" ];
  };
}
 

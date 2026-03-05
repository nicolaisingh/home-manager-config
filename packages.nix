{
  pkgs,
}:

let
  cura-appimage = pkgs.appimageTools.wrapType2 {
    pname = "cura";
    version = "5.10.1";
    src = pkgs.fetchurl {
      url = "https://github.com/Ultimaker/Cura/releases/download/5.10.1/UltiMaker-Cura-5.10.1-linux-X64.AppImage";
      sha256 = "sha256-c89GkgfOSY4hriY66GUCgBYiiJJspM9Fg07lne+KXgw=";
    };
    profile = with pkgs; ''
      export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
    '';
  };

  guarda = pkgs.appimageTools.wrapType2 {
    # Use wrapType1 if `file -k' on the AppImage shows an ISO 9660
    # CD-ROM filesystem
    pname = "guarda";
    version = "1.1.1";
    # src = ./appimages/Guarda-1.1.1.AppImage;
    src = pkgs.fetchurl {
      url = "https://github.com/guardaco/guarda-desktop-releases/releases/download/v1.1.1/Guarda-1.1.1.AppImage";
      sha256 = "sha256-5UYysVsyhxdy8tOJTwSDZGwIY7sHvhmcOUptbRKXgUo=";
    };
    profile = with pkgs; ''
      export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
    '';
  };

  my-python = (
    pkgs.python311.withPackages (
      ps: with ps; [
        flask
        pip
        pyflakes
        setuptools
        tomlkit
        virtualenv
      ]
    )
  );

in
with pkgs;
[
  # Fonts
  atkinson-hyperlegible-mono
  atkinson-hyperlegible-next

  android-tools
  appimage-run
  asciidoctor
  at
  audacity
  bandwhich
  black
  calc
  calf
  ccl
  clinfo
  clisp
  clojure
  cura
  dbeaver-bin
  dconf2nix
  ditaa
  easyeffects
  electrum
  exiftool
  exiv2
  eyedropper
  feh
  freecad
  gimp
  git-filter-repo
  gnome-extension-manager
  gnome-themes-extra
  gnucash
  graphviz
  guarda
  imagemagick
  inkscape
  isync # mbsync
  libreoffice
  lm_sensors
  localsend
  lsb-release
  lshw
  masterpdfeditor
  mermaid-cli
  mitscheme
  mp3gain
  mpg123
  mtr
  my-python
  nicotine-plus
  nixd # nix LSP (Setup guide: https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md)
  nixfmt
  nmap
  nodePackages.prettier
  nodePackages.typescript-language-server
  nodejs
  noise-repellent
  nomacs
  obs-studio
  openvpn
  orchis-theme
  p7zip
  pandoc
  paperkey
  picard
  plantuml
  pyright
  qmk
  qrencode
  quodlibet-full
  rar
  ripgrep
  rst2pdf
  rubyPackages.rdoc
  sbcl
  scrcpy
  shntool
  silver-searcher
  sqlite
  teams-for-linux
  telegram-desktop
  tor-browser
  transmission_4-gtk
  uv
  via
  vim
  vlc
  vorbis-tools
  vorbisgain
  wasabiwallet
  webcamoid
  yt-dlp
  zbar
  zoom-us

  unstable.aider-chat
  unstable.reaper

  # Installed in dnf:
  ## Apps
  # calibre (ebook-viewer does not work in hm)
  # dconf-editor
  # gnome-tweaks
  # steam
  ## Graphics-related
  # egl-utils
  # lact
  # libva-utils
  # mesa-demos
  # vulkan-tools
]

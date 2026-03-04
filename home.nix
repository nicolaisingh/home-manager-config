{
  config,
  pkgs,
  lib,
  ...
}:
let
  name = "Nicolai Singh";
  email = "nicolaisingh@pm.me";
  githubUsername = "nicolaisingh";
  username = "nas";
  homeDirectory = "/home/nas";
  packages = import ./packages.nix { inherit pkgs; };
  dconfSettings = import ./dconf.nix { inherit lib; };
in
{
  home = {
    stateVersion = "25.11";

    inherit username homeDirectory;
    inherit packages;
    file = {
      "Music".source = config.lib.file.mkOutOfStoreSymlink "/mnt/files/music";

      ".aider.model.settings.yml".text = ''
        - name: o3-mini
          edit_format: diff
          weak_model_name: gpt-4o-mini
          use_repo_map: true
          use_temperature: false
          editor_model_name: gpt-4o
          editor_edit_format: editor-diff
      '';

      # Load home-manager session vars separately
      ".bashrc.d/home-manager-session-vars".text = ''
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';

      ".bashrc.d/aliases".text = ''
        alias ..="cd .."
        alias ...="cd ../.."
        alias df="df -h"
        alias ll="ls -lh --color=auto"
      '';
    };
  };

  dconf = {
    enable = true;
    settings = dconfSettings;
  };

  fonts.fontconfig.enable = true;

  programs = {
    awscli.enable = true;

    chromium.enable = true;

    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };

    git = {
      enable = true;
      settings = {
        alias = {
          s = "status";
          plog = "log --graph --format=format:'%C(red)%h%C(reset)%C(auto)%d%C(reset) %s%C(blue) -- %an %C(magenta)(%ar)%C(reset)'";
          dlog = "log --graph --format=format:'%C(red)%h%C(reset)%C(auto)%d%C(reset)%n'";
          dummy-commit = "!f() { echo 'this is a sample edit' >> `git rev-parse --abbrev-ref HEAD`; git commit -a -m 'test commit'; }; f";
        };
        user.name = name;
        user.email = email;

        # For emacs forge:
        # https://magit.vc/manual/forge.html#Set-your-Username-1
        github.user = githubUsername;
      };
    };

    gnome-shell = {
      enable = true;
      extensions = with pkgs.gnomeExtensions; [
        { package = caffeine; }
        { package = dash-to-dock; }
        { package = dash-to-panel; }
        { package = clipboard-indicator; }
      ];
    };

    home-manager.enable = true;

    htop = {
      enable = true;
    };

    librewolf.enable = true;

    password-store = {
      enable = true;
      package = (pkgs.pass.withExtensions (exts: [ exts.pass-otp ]));
    };

    mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        mpris
      ];
    };

    msmtp.enable = true;

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          forwardAgent = false;
          addKeysToAgent = "no";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        };
        horaios = {
          hostname = "192.168.70.10";
        };
        yaldabaoth = {
          hostname = "192.168.70.11";
        };
      };
    };

    texlive = {
      enable = true;
      extraPackages = tpkgs: {
        inherit (tpkgs)
          booktabs
          cabin
          capt-of
          enumitem
          geometry
          hyperref
          libertine
          lipsum
          ly1
          mathdesign
          scheme-medium
          wrapfig
          ;
      };
    };
  };

  services = {
    emacs = {
      enable = true;
      client.enable = true;
      defaultEditor = true;
      startWithUserSession = "graphical";
    };

    protonmail-bridge = {
      enable = true;
    };
  };

  systemd = {
    user.services.emacs.Service = {
      Restart = lib.mkOverride 0 "always";
      RestartOnSec = "1s";
    };
  };
}

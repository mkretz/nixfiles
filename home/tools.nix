{ config, pkgs, ... }:

{
  programs = {
    # Git
    git = {
      enable = true;
      userName = "Mathis Kretz";
      userEmail = "2479543+mkretz@users.noreply.github.com";
      signing = {
        key = null;
        signByDefault = true;
      };
      diff-so-fancy.enable = true;
    };
    gitui.enable = true;

    # File manager
    broot = {
      enable = true;
      settings.verbs = [
        { invocation = "edit"; shortcut = "e"; execution = "$EDITOR {file}:{line}"; }
      ];
    };

    # Encryption
    gpg.enable = true;

    # Fuzzy finder
    fzf.enable = true;

    # Fast grepping
    ripgrep.enable = true;

    # Process viewer
    bottom.enable = true;

    # Quick navigation
    zoxide.enable = true;

    # Password manager
    browserpass.enable = true;

    # JSON parser
    jq.enable = true;

    # PDF viewer
    zathura.enable = true;

    # Task management
    taskwarrior.enable = true;

    # Media player
    mpv.enable = true;

    # GitHub CLI
    gh.enable = true;

    # Image viewer
    imv.enable = true;

    # Go
    go.enable = true;

    # Simplified manuals
    tealdeer = {
      enable = true;
      settings = {
        updates.auto_update = true;
      };
    };
  };

  home.packages = with pkgs; [
    altair
    awscli2
    brave
    cargo
    chromium
    clippy
    curl
    diff-so-fancy
    dig
    fd
    fx
    gcc
    gimp
    gnumake
    golangci-lint
    gopass
    hugo
    inkscape
    jpegoptim
    kubectl
    kubectx
    libreoffice
    libwebp
    lolcat
    lutris
    moq
    ncdu
    nmap
    nodejs
    nodePackages.svgo
    opentofu
    optipng
    poetry
    pulsemixer
    pwgen
    python3
    quickemu
    realvnc-vnc-viewer
    rustc
    shellcheck
    signal-desktop
    slides
    termshark
    tflint
    timewarrior
    tree
    unzip
    upterm
    wf-recorder
    wget
    whois
    wl-clipboard
    xdg-utils
    yq
    zip
  ];
}

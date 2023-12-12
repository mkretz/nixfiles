{
  config,
  pkgs,
  theme,
  ...
}:

{
  programs = {
    # Nix helper
    nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/.nixfiles";
    };

    # Git
    git = {
      enable = true;
      settings = {
        user = {
          name = "Mathis Kretz";
          email = "mkretz@users.noreply.github.com";
        };
      };
    };

    # Git TUI
    gitui.enable = true;

    # Diff viewer
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        minus-style = "red #${theme.colors.dangerDark}";
        minus-emph-style = "red #${theme.colors.dangerLight}";
        plus-style = "green #${theme.colors.successDark}";
        plus-emph-style = "green #${theme.colors.successLight}";
        zero-style = "white";
        line-numbers = true;
        line-numbers-minus-style = "white #${theme.colors.dangerDark}";
        line-numbers-plus-style = "white #${theme.colors.successDark}";
        line-numbers-zero-style = "white";
      };
    };

    # Merge tool
    mergiraf = {
      enable = true;
      enableGitIntegration = true;
    };

    # System information tool
    fastfetch.enable = true;

    # Agentic coding tool
    claude-code.enable = true;

    # File manager
    yazi.enable = true;

    # Encryption
    gpg.enable = true;

    # Fuzzy finder
    fzf.enable = true;

    # Faster find
    fd.enable = true;

    # Faster grepping
    ripgrep.enable = true;

    # Process viewer
    bottom.enable = true;

    # Quick navigation
    zoxide.enable = true;

    # JSON parser
    jq.enable = true;

    # GitHub CLI
    gh.enable = true;

    # Simplified man pages
    tealdeer = {
      enable = true;
      settings = {
        updates.auto_update = true;
      };
    };

    # AWS CLI
    awscli.enable = true;

    # Go
    go.enable = true;

    # Node.js
    npm.enable = true;

    # Python
    uv.enable = true;
  };

  home.packages = with pkgs; [
    air
    brave
    cargo
    claude-code
    clippy
    dig
    dust
    file
    fx
    golangci-lint
    google-cloud-sdk
    hugo
    image_optim
    inkscape
    kubectl
    kubectx
    libwebp
    lolcat
    moq
    onefetch
    opentofu
    optipng
    podman
    podman-compose
    presenterm
    pwgen
    python3
    rustc
    shellcheck
    signal-desktop
    tflint
    timewarrior
    tree
    unzip
    typst
    upterm
    vfkit
    whois
    yq-go
    zip
  ];

  home.preferXdgDirectories = true;
}

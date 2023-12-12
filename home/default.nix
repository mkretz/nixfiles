{ config, ... }:

{
  imports = [
    ./fonts.nix
    ./terminal.nix
    ./shell.nix
    ./editor.nix
    ./tools.nix
  ];

  # Pass theme to all imported modules
  _module.args.theme = import ./theme.nix;

  home.username = "mathiskretz";
  home.homeDirectory = "/Users/${config.home.username}";

  home.stateVersion = "26.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}

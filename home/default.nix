{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./terminal.nix
    ./editor.nix
    # ./tools.nix
    ./upgrade-diff.nix
  ];

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.username = "mathiskretz";
  home.homeDirectory = "/Users/${config.home.username}";

  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fira-mono
    nerd-fonts.fira-code
    lato
  ];
}

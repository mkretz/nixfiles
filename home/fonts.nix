{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fira-mono
    fira-code-nerdfont
    lato
  ];
}

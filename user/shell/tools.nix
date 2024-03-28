{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    htop
    btop
    lazygit
    nix-search-cli
  ];
}

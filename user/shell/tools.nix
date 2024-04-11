{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wget
    tree
    htop
    btop
    lazygit
    nix-search-cli
    dig
    gh
    unzip
    tldr
  ];
}

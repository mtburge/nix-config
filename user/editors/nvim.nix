{ pkgs, ... }:

{
  programs.neovim = {
    defaultEditor = true;
    vimAlias = true;
  };
}

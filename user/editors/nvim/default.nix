{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    gnumake
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  home.file.".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink ./init.lua;

  home.file.".config/nvim/lua" = {
    source = ./lua;
    recursive = true;
  };
}

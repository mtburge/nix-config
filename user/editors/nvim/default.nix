{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    gnumake
    ripgrep
    fd
    gcc
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  home.file.".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/mtburge/.dotfiles/user/editors/nvim/init.lua";
  home.file.".config/nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "/home/mtburge/.dotfiles/user/editors/nvim/lua/";
}

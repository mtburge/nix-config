{ pkgs, ... }:

{
  fonts.packages= with pkgs; [
    #font-awesome
    line-awesome
  ];
}

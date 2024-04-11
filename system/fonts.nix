{ pkgs, ... }:

{
  fonts.packages= with pkgs; [
    line-awesome
    (nerdfonts.override { fonts = ["LineAwesome", "JetBrains Mono"] })
  ];
}

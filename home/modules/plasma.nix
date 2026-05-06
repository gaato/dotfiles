{ pkgs, ... }:

let
  catppuccinKde = pkgs.catppuccin-kde.override {
    flavour = [ "latte" ];
    accents = [ "mauve" ];
    winDecStyles = [ "modern" ];
  };
in

{
  home.packages = with pkgs; [
    catppuccinKde
    catppuccin-cursors.latteMauve
    papirus-icon-theme
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    fonts = {
      general = {
        family = "BIZTER";
        pointSize = 10;
      };
      fixedWidth = {
        family = "HackGen Console NF";
        pointSize = 10;
      };
      menu = {
        family = "BIZTER";
        pointSize = 10;
      };
      small = {
        family = "BIZTER";
        pointSize = 8;
      };
      toolbar = {
        family = "BIZTER";
        pointSize = 10;
      };
      windowTitle = {
        family = "BIZTER";
        pointSize = 10;
      };
    };

    workspace = {
      lookAndFeel = "Catppuccin-Latte-Mauve";
      colorScheme = "CatppuccinLatteMauve";
      cursor = {
        theme = "catppuccin-latte-mauve-cursors";
        size = 24;
      };
      iconTheme = "Papirus";
    };

    configFile.kwinrc."org.kde.kdecoration2" = {
      library = "org.kde.kwin.aurorae";
      theme = "__aurorae__svg__CatppuccinLatte-Modern";
    };
  };
}

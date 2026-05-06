{ ... }:

{
  programs.konsole = {
    enable = true;
    defaultProfile = "Gaato";
    customColorSchemes."CatppuccinLatteMauve" = ./konsole/CatppuccinLatteMauve.colorscheme;
    profiles.Gaato = {
      name = "Gaato";
      colorScheme = "CatppuccinLatteMauve";
      font = {
        name = "HackGen Console NF";
        size = 10;
      };
    };
    ui.colorScheme = "CatppuccinLatteMauve";
  };
}

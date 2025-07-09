{ 
  config,
  pkgs,
  ...
}:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "23.11";

  programs.zsh.enable = true;

  home.packages = with pkgs; [
    git
    fzf
    zoxide
    eza
    neovim
    wezterm
    emacs
    ripgrep
    pyenv
    goenv
    nvm
  ];

  home.file.".zshrc".source = ./.zshrc;
  home.file.".zshrc.d".source = ./.zshrc.d;
  home.file.".vimrc".source = ./.vimrc;
  home.file.".nanorc".source = ./.nanorc;
  home.file.".config/nvim/init.lua".source = ./.config/nvim/init.lua;
  home.file.".config/wezterm/wezterm.lua".source = ./.config/wezterm/wezterm.lua;
  home.file.".config/doom/config.el".source = ./.config/doom/config.el;
  home.file.".config/doom/init.el".source = ./.config/doom/init.el;
  home.file.".config/doom/packages.el".source = ./.config/doom/packages.el;
}

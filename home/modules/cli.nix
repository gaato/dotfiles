{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fastfetch
    fd
    firefox
    gh
    ghq
    jq
    mise
    nano
    ripgrep
    uv
  ];
}

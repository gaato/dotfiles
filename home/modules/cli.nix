{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fastfetch
    fd
    firefox
    ghq
    jq
    mise
    nano
    ripgrep
    uv
  ];
}

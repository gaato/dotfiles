{ pkgs, ... }:

let
  dvorakjpRomanTable = pkgs.fetchFromGitHub {
    owner = "shinespark";
    repo = "dvorakjp-roman-table";
    rev = "94f8f303323824e1faa39ebfb2556cd365cad149";
    hash = "sha256-YqwzywcmE/abbfWAKICAAp8Mw/FzIpNAxoiXoYpnVNg=";
  };
in

{
  xdg.dataFile."mozc/roman-tables/dvorak_jp.tsv".source =
    "${dvorakjpRomanTable}/outputs/google_japanese_input/dvorak_jp.tsv";

  xdg.dataFile."mozc/roman-tables/dvorak_jp_with_emoji.tsv".source =
    "${dvorakjpRomanTable}/outputs/google_japanese_input/dvorak_jp_with_emoji.tsv";
}

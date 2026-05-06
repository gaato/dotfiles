{ ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Gakuto Furuya";
        email = "g.furuya@gaato.net";
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.config/git/allowed_signers";
      };
      init.defaultBranch = "main";
    };
  };

  xdg.configFile."git/allowed_signers".text = ''
    g.furuya@gaato.net ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID0Sec1Ywy0776t1eGB6zxMHHGmFqNFLK/c9GNJbWCnW gaato@tw
  '';
}

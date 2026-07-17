# エディタは daemon 稼働中の Emacs に接続する (herdr ペインでは -t でTUI)
set -gx EDITOR "emacsclient -t"
set -gx VISUAL "emacsclient -c"

abbr -a e "emacsclient -t"
abbr -a ec "emacsclient -c"

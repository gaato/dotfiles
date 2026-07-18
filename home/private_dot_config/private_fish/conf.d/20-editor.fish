# エディタは daemon 稼働中の Emacs に接続する (herdr ペインでは -t でTUI)
# クォートせずリストで持つ: fish で `$EDITOR file` と打ったときに引数分割されるように
# (子プロセスへはスペース結合で export されるので sh 系からも従来通り動く)
set -gx EDITOR emacsclient -t
set -gx VISUAL emacsclient -c

abbr -a e "emacsclient -t"
abbr -a ec "emacsclient -c"

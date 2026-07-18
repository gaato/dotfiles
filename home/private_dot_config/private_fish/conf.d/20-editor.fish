# さくっと編集は nano、本気の編集は abbr の e/ec から Emacs daemon へ
# VISUAL は設定しない (git 等が VISUAL を優先して nano が効かなくなるため)
set -gx EDITOR nano

abbr -a e "emacsclient -t"
abbr -a ec "emacsclient -c"

function fish_greeting
    # chezmoi-drift.timer が書くキャッシュがあれば1行だけ知らせる
    set -l cache (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)/chezmoi-drift
    if test -s $cache
        set_color yellow
        echo "dotfiles drift: "(count (cat $cache))" file(s) — /dotfiles で処理できます"
        set_color normal
    end
end

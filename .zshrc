##############################
# Default shell configuration#
##############################
zcompile ~/.zshrc  # .zshrcをコンパイルし、.zshrc.zwcを生成
zcompile ~/.zshrc.mine  # .zshrc.mineをコンパイルし、.zshrc.mine.zwcを生成

bindkey -v  # Vi ライクなキーバインドを使う
export LANG=ja_JP.UTF-8  # LANG

if [ -f /etc/zshrc ]; then
    source /etc/zshrc
fi


#############################
#      プロンプトの設定      #
#############################
# %% %を表示
# %) )を表示
# %l 端末名省略形
# %M ホスト名(FQDN)
# %m ホスト名(サブドメイン)
# %n ユーザー名
# %y 端末名
# %# rootなら#、他は%を表示
# %? 直前に実行したコマンドの結果コード
# %d ワーキングディレクトリ %/ でも可
# %~ ホームディレクトリからのパス
# %h ヒストリ番号 %! でも可
# %a The observed action, i.e. "logged on" or "logged off".
# %S (%s) 反転モードの開始/終了 %S abc %s とするとabcが反転
# %U (%u) 下線モードの開始/終了 %U abc %u とするとabcに下線
# %B (%b) 強調モードの開始/終了 %B abc %b とするとabcを強調
# %t 時刻表示(12時間単位、午前/午後つき) %@ でも可
# %T 時刻表示(24時間表示)
# %* 時刻表示(24時間表示秒付き)
# %w 日表示(dd) 日本語だと 曜日 日
# %W 年月日表示(mm/dd/yy)
# %D 年月日表示(yy-mm-dd)

setopt prompt_subst  # $PROMPT 内の変数を展開する
setopt transient_rprompt  # コピーするときに$RPROMPT を非表示にする

PROMPT="[%F{red}%.%f]%(!.#.$) "
PROMPT2="%F{magenta}%_ %%%f "
SPROMPT='Correct: %F{red}%R%f -> %F{green}%r%f ? [n, y, a, e] '
RPROMPT=""

if test ${UID} -eq 0; then
    PROMPT="%B${PROMPT}%b"
    PROMPT2="%B${PROMPT2}%b"
    SPROMPT="%B${SPROMPT}%b"
fi

#############################
#        補完の設定         #
#############################
autoload -U compinit; compinit

#setopt auto_correct  # 補完時にスペルチェック
setopt correct  # スペルミスを補完
setopt list_packed  # 補完候補をコンパクトに設定
setopt nolistbeep  # ビープ音を鳴らさずに補完候補を表示
setopt auto_menu  # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys  # カッコの対応などを自動的に補完
setopt auto_remove_slash  # 補完で末尾に補われた / を自動的に削除
setopt auto_param_slash  # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs  # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types  # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
unsetopt menu_complete  # 補完の際に、可能なリストを表示してビープを鳴らすのではなく、
                        # 最初にマッチしたものをいきなり挿入、はしない
setopt auto_resume  # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt complete_in_word  # 語の途中でもカーソル一で補完を行う
setopt print_eight_bit  # 補完候補リストの日本語を適正表示
setopt magic_equal_subst  # コマンドラインの引数で --PREFIX=/USR などの = 以降でも補完できる

if [[ "${OSTYPE}" = linux* ]]; then
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # 補完候補を色付き表示
fi
zstyle ':completion:*' use-cache true        # 補完キャッシュ
zstyle ':completion:*:processes' command 'ps x'  # kill で 'ps x' のリストから選択可能
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'  # kill の候補を色付き表示


################################
#          履歴の設定          #
################################
HISTFILE=~/.zsh_history  # 履歴を保存するファイル名
HISTSIZE=10000  # メモリ内の履歴数
SAVEHIST=10000  # 記録される履歴数
setopt share_history  # 履歴の共有
setopt hist_expand  # 補完時にヒストリを自動的に展開
setopt extended_history  # 履歴ファイルに開始時刻と経過時間を記録
setopt append_history  # 履歴を追加 (毎回 .zhistory を作るのではなく)
setopt inc_append_history  # 履歴をインクリメンタルに追加
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups  # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_space  # スペースで始まるコマンド行はヒストリリストから削除
setopt hist_reduce_blanks  # 余分な空白は詰めて記録
setopt hist_save_no_dups  # ヒストリファイルに書き出すときに、古いコマンドと同じものは無視する。
setopt hist_no_store  # historyコマンドは履歴に登録しない

# コマンド履歴を検索する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end  # Ctrl-P で前のコマンド履歴を選択
bindkey "^N" history-beginning-search-forward-end  # Ctrl-N で次のコマンド履歴を進む

# コマンド履歴による予測補完 (man zshcontrib)
autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey '^xp'  predict-on  # Ctrl+x p でコマンド履歴による予測補完オン
bindkey '^x^p' predict-off  # Ctrl+x Ctrl+p でコマンド履歴による予測補完オフ


################################
#    ディレクトリ移動の設定    #
################################
setopt auto_cd   # ディレクトリ名のみで移動
setopt auto_pushd  # 普通に cd するときにもディレクトリスタックにそのディレクトリを入れる
setopt pushd_ignore_dups  # ディレクトリスタックに重複する物は古い方を削除
setopt pushd_to_home  # pushd 引数ナシ == pushd $HOME
setopt pushd_silent  # pushd,popdの度にディレクトリスタックの中身を表示しない


################################
#            Alias             #
################################
alias where="command -v"
alias j="jobs -l"
if [[ "${OSTYPE}" = linux* ]]; then
    alias ls="ls --color"
elif [[ "${OSTYPE}" = darwin* ]]; then
    alias ls="ls -G"
fi
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l -h"
alias du="du -h"
alias df="df -h"
alias su="su -l"

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g S='| sed'
alias -g A='| awk'
alias -g W='| wc'

if [[ "${OSTYPE}" = darwin* ]]; then
    alias google-chrome='open -a Google\ Chrome'
    alias eog='open -a Preview'
fi
alias -s {png,gif,jpg,bmp,PNG,GIF,JPG,BMP}=eog
alias -s html=google-chrome


################################
#          雑多な設定          #
################################
# setopt no_beep  # コマンド入力エラーでBeepを鳴らさない

setopt brace_ccl  # ブレース展開機能を有効にする
setopt numeric_glob_sort  # 数字を数値と解釈してソートする
setopt path_dirs  # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す

setopt ignore_eof  # C-dでログアウトしない

setopt bsd_echo
setopt notify  # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt long_list_jobs  # 内部コマンドjobs の出力をデフォルトでjobs -L にする

setopt multios  # 複数のリダイレクトやパイプなど、必要に応じて TEE や CAT の機能が使われる
setopt short_loops  # FOR, REPEAT, SELECT, IF, FUNCTION などで簡略文法が使えるようになる
setopt always_last_prompt  # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt cdable_vars sh_word_split

REPORTTIME=3  # n 秒以上かかった処理の詳細を表示する

setopt rm_star_wait  # rm * を実行する前に確認

# タイトルバーの動的変更
precmd() {
    [[ -t 1 ]] || return
    case $TERM in
        sun-cmd)
            print -Pn "\e]l[%~]\e\\"
            ;;
        *xterm*|rxvt|(dt|k|E)term)
            print -Pn "\e]2;[%~]\a"
            ;;
    esac
}

# google 検索
function google() {
    local str
    if [ $# != 0 ]; then # 引数が存在すれば
        for i in $*; do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'` #先頭の「+」を削除
    fi

    if [[ "${OSTYPE}" = darwin* ]]; then
        open -a "Google Chrome" "http://www.google.co.jp/search?hl=ja&q=$str"
    elif [[ "${OSTYPE}" = linux* ]]; then
        w3m "http://www.google.co.jp/search?hl=ja&q=$str"
    else;
        iceweasel "http://www.google.co.jp/search?hl=ja&q=$str"
    fi
}

# wikipedia 検索
function wikipedia() {
    if [[ "${OSTYPE}" = darwin* ]]; then
        open -a "Google Chrome" "http://ja.wikipedia.org/wiki/$1"
    elif [[ "${OSTYPE}" = linux* ]]; then
        w3m "http://ja.wikipedia.org/wiki/$1"
    else;
        iceweasel "http://ja.wikipedia.org/wiki/$1"
    fi
}


################################
#      個人設定を読み込む      #
################################
if [ -f ~/.zshrc.mine ]; then
    source ~/.zshrc.mine
fi

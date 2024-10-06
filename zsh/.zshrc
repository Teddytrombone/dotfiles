#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi
export PATH=$HOME/bin:$HOME/bin/.local:$HOME/.bin:$HOME/.bin/.local:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

###############
# some SVN related stuff - would be removed in future 
###############

function prompt_svn_status_info() {
  local svn_status_string="$ZSH_THEME_SVN_PROMPT_CLEAN"
  local svn_status="$(svn status 2>/dev/null)";
  if command grep -E '^\s*A' &>/dev/null <<< "$svn_status"; then
    svn_status_string+="${ZSH_THEME_SVN_PROMPT_ADDITIONS:-+}"
  fi
  if command grep -E '^\s*D' &>/dev/null <<< "$svn_status"; then
    svn_status_string+="${ZSH_THEME_SVN_PROMPT_DELETIONS:-✖}"
  fi
  if command grep -E '^\s*M' &>/dev/null <<< "$svn_status"; then
    svn_status_string+="${ZSH_THEME_SVN_PROMPT_MODIFICATIONS:-✎}"
  fi
  if command grep -E '^\s*[R~]' &>/dev/null <<< "$svn_status"; then
    svn_status_string+="${ZSH_THEME_SVN_PROMPT_REPLACEMENTS:-∿}"
  fi
  if command grep -E '^\s*\?' &>/dev/null <<< "$svn_status"; then
    svn_status_string+="${ZSH_THEME_SVN_PROMPT_UNTRACKED:-?}"
  fi
  if command grep -E '^\s*[CI!L]' &>/dev/null <<< "$svn_status"; then
    svn_status_string+="${ZSH_THEME_SVN_PROMPT_DIRTY:-!}"
  fi
  echo $svn_status_string
}

prompt_svn() {
    local rev branch
    SVN_INFO=$(LANG= svn info 2> /dev/null)
	local result=$?
    if [ $result -eq 0 ]; then
		info=$(prompt_svn_status_info)
        rev=$(echo "$SVN_INFO" | sed -n 's/Revision: //p')
        branch=$(grep '^URL:' <<< "$SVN_INFO" | grep -Eo '(tags|branches)/[^/]+|trunk')
        combined="$rev  $branch"
        if [[ ! -z $info ]]; then
            prompt_segment yellow black
            echo -n "$combined $info"
        else
            prompt_segment green black
            echo -n "$combined ✔"
        fi
    fi
}

#############
# COMPLETION
#############
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/manfred/.zshrc'

autoload -Uz compinit
compinit
SAVEHIST=10000

##########
# HISTORY
##########

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
HIST_STAMPS="yyyy-mm-dd"

setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Dont write duplicate entries in the history file.

setopt inc_append_history
setopt share_history

###############
# KEY BINDINGS
###############

bindkey -e

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey -s "^f" "tmux-sessionizer.sh\n"


###############
# MISC
###############
setopt autocd extendedglob



###############
# ALIASES in separate file
###############
source ~/.aliases


###############
# Finally load theme and oh-my-zsh
###############

plugins=(colored-man-pages command-not-found common-aliases copypath copyfile cp debian dircycle dirhistory dirpersist emoji-clock emoji gitfast history-substring-search history man nmap rand-quote rsync ssh-agent sudo web-search)

if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
	source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f "$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
	source "$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
else
    echo "powerlevel10k not found, please install it"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if command -v kitty &> /dev/null; then
    if [[ $TERM == "xterm-kitty" ]]; then
        if [[ -d "$HOME/Bilder/Wallpaper/" ]]; then
            background=$(ls "$HOME/Bilder/Wallpaper/"*.png | sort --random-sort | head -1)
            if [[ ! -z $background ]]; then
                kitty @ set-background-image "$background" 
            fi
        fi
    fi
fi

source $ZSH/oh-my-zsh.sh


if [ -e /usr/share/fzf/completion.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
elif [ -e /usr/share/doc/fzf/examples/completion.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

if command -v bat &> /dev/null; then
    BAT_COMMAND='bat'
fi
if command -v batcat &> /dev/null; then
    BAT_COMMAND='batcat'
fi


if [ ! -z "${BAT_COMMAND}" ]; then
    export BAT_THEME=Dracula
    export FZF_CTRL_T_OPTS="--preview '${BAT_COMMAND} -n --color=always --line-range :500 {}'"
fi

if command -v eza &> /dev/null; then
    export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
fi

if [ ! -z "${BAT_COMMAND}" ]; then
    if command -v eza &> /dev/null; then
        show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else ${BAT_COMMAND} -n --color=always --line-range :500 {}; fi"

        _fzf_comprun() {
            local command=$1
            shift

            case "$command" in
                cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
                export|unset) fzf --preview "eval 'echo $'{}" "$@" ;;
                ssh)          fzf --preview 'dig {}' "$@" ;;
                *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
            esac
        }
    fi
fi

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

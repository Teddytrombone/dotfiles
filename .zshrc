# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin:$HOME/bin/.local:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/manfred/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
bindkey -e

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey -s "^f" "tmux-sessionizer.sh\n"
HIST_STAMPS="yyyy-mm-dd"

source ~/.aliases

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(svn colored-man-pages command-not-found common-aliases copydir copyfile cp debian dircycle dirhistory dirpersist emoji-clock emoji gitfast gnu-util history-substring-search history iwhois man nmap rand-quote rsync ssh-agent sudo tmux web-search zsh-syntax-highlighting timewarrior)
plugins=(colored-man-pages command-not-found common-aliases copypath copyfile cp debian dircycle dirhistory dirpersist emoji-clock emoji gitfast history-substring-search history man nmap rand-quote rsync ssh-agent sudo web-search)

if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
	source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f "$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
	source "$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if command -v kitty &> /dev/null; then
    if [[ $TERM -eq "xterm-kitty" ]]; then
        if [[ -d "$HOME/Bilder/Wallpaper/" ]]; then
            background=$(ls "$HOME/Bilder/Wallpaper/"*.png | sort --random-sort | head -1)
            if [[ ! -z $background ]]; then
                kitty @ set-background-image "$background" 
            fi
        fi
    fi
fi

source $ZSH/oh-my-zsh.sh



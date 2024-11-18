#!/usr/bin/env bash

PROJECTS="/var/www"
DEFAULT="${USER}-default"

ZOXIDE_AVAILABLE=1
command -v zoxide >/dev/null 2>&1 || {
	echo >&2 "Zoxide is recommended, please consider installing it."
	ZOXIDE_AVAILABLE=0
}

# increase frecency
function increase {
	if [ $ZOXIDE_AVAILABLE -eq 0 ]; then
		return 0
	fi
	SELECTED="$1"
	if [[ "$SELECTED" == "$DEFAULT" ]]; then
		return 0
	fi
	zoxide add "$SELECTED"
}

function search {
	projects=$(find "$PROJECTS" -mindepth 1 -maxdepth 1 -type d)
	if [ $ZOXIDE_AVAILABLE -eq 1 ]; then
		projects=$(
			echo "${projects[@]}" |
				while read -r p; do
					# get the projects in each namespace with their zoxide scores
					Z_RESULT=$(zoxide query -l -s "$p")
					if [[ -z $Z_RESULT ]]; then
						echo "0 $p"
					else
						echo "$Z_RESULT"
					fi
				done |
				sort -rnk1 |
				awk '{print $2}'
		)
	fi
	#	projects=("${projects[@]}" "em-default")
	echo "$(
		echo "$DEFAULT"
		echo "${projects[@]}"
	)" | fzf-tmux --no-sort --prompt "  "
}

if [[ $# -eq 1 ]]; then
	selected=$1
else
	selected=$(search)
fi

if [[ -z $selected ]]; then
	exit 0
fi

increase "$selected"

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

function initTmuxSession {
	tmux new-session "$1" -s "$selected_name" -c "$selected" -n "Root"
    if [[ -d "$selected/packages" ]]; then
        PACKAGES="$selected/packages"
    elif [[ -d "$selected/typo3conf/ext" ]]; then
        PACKAGES="$selected/typo3conf/ext"
    fi

    if [[ -n "$PACKAGES" && -d "$PACKAGES/bc_kunden_$selected_name" ]]; then
        echo "Found" >> ~/inittmux
        tmux new-window -t "$selected_name":2 -n "KundenExt" -c "$PACKAGES/bc_kunden_$selected_name" 
    fi

    tmux select-window -t "$selected_name":1 
}

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    initTmuxSession
	exit 0
fi

if ! tmux has-session -t="$selected_name" 2>/dev/null; then
    initTmuxSession -d
fi

tmux switch-client -t "$selected_name"

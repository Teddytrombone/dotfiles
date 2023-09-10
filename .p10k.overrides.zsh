typeset -g POWERLEVEL9K_VCS_BACKENDS=(git svn)

typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='!'
typeset -g POWERLEVEL9K_VCS_STAGED_ICON='+'
typeset -g POWERLEVEL9K_VCS_SVN_DELETED_ICON='✖'
typeset -g POWERLEVEL9K_VCS_SVN_MODIFIED_ICON='✎'
typeset -g POWERLEVEL9K_VCS_SVN_REPLACEMENTS_ICON='∿'

branchIcon=' '
zstyle ':vcs_info:svn*:*' branchformat "$branchIcon%b"
zstyle ':vcs_info:svn*:*' get-revision true
zstyle ':vcs_info:svn*:*' formats "$prefix%b %c%u%m"

function +vi-svn-detect-changes() {
  local svn_status="$(svn status 2>/dev/null)"
  if [[ -n "$(echo "$svn_status" | \grep \^\A)" ]]; then
    hook_com[staged]+="$(print_icon 'VCS_STAGED_ICON')"
    VCS_WORKDIR_DIRTY=true
  fi
  if [[ -n "$(echo "$svn_status" | \grep \^\D)" ]]; then
    hook_com[staged]+="$(print_icon 'VCS_SVN_DELETED_ICON')"
    VCS_WORKDIR_DIRTY=true
  fi
  if [[ -n "$(echo "$svn_status" | \grep \^\M)" ]]; then
    hook_com[staged]+="$(print_icon 'VCS_SVN_MODIFIED_ICON')"
    VCS_WORKDIR_DIRTY=true
  fi
  if [[ -n "$(echo "$svn_status" | \grep \^\[\R\~\])" ]]; then
    hook_com[staged]+="$(print_icon 'VCS_SVN_REPLACEMENTS_ICON')"
    VCS_WORKDIR_DIRTY=true
  fi
  if [[ -n "$(echo "$svn_status" | \grep \^\?)" ]]; then
    hook_com[unstaged]+="$(print_icon 'VCS_UNTRACKED_ICON')"
    VCS_WORKDIR_HALF_DIRTY=true
  fi
  if [[ -n "$(echo "$svn_status" | \grep \^\[\C\I\!\L\])" ]]; then
    hook_com[unstaged]+="$(print_icon 'VCS_UNSTAGED_ICON')"
    VCS_WORKDIR_DIRTY=true
  fi
  
  revision=$(svn info --show-item revision)
  hook_com[revision]="${revision}"
}

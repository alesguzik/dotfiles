# this file is not supposed to be loaded more than once
if [ -n "$ZPROFILE_LOADED" ]; then
  playnote # for debug reasons
  return
fi
export ZPROFILE_LOADED=true

function source-if-exist { [ -e "$1" ] && source "$1" }

source-if-exist "$HOME/.env-reloadable"

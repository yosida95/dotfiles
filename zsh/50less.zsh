export LESS='-giMR'
export LESSCHARSET=utf-8

if (($+commands[lesspipe])); then
  . <(lesspipe)
elif (($+commands[lesspipe.sh])); then
  . <(lesspipe.sh)
fi

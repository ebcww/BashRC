readonly LD_PRELOAD
readonly LD_LIBRARY_PATH
alias ls="ls -lhaZ"
alias ps="ps -Z"
clear;fastfetch -l Aperture  --pipe false
PROMPT_COMMAND='PS1_CMD1=$(id -Z); PS1_CMD2=$(id -u); PS1_CMD3=$(ip route get 1.1.1.1 | awk -F"src " '"'"'NR == 1{ split($2, a," ");print a[1]}'"'"'); PS1_CMD4=$(pwd)'; PS1='\[\e[91m\][\[\e[93m\]${PS1_CMD1}\[\e[91m\]]\[\e[0m\] \[\e[35m\]\u\[\e[0m\]:\[\e[95m\]${PS1_CMD2}\[\e[0m\]@\[\e[96m\]\h\[\e[0m\]:\[\e[96m\]${PS1_CMD3}\[\e[0m\](\[\e[92m\]${PS1_CMD4}\[\e[0m\])\n\[\e[94m\]#\[\e[93m\]\T\[\e[91m\]>\[\e[0m\] '


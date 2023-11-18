alias his=history
alias datetime='date +%Y%m%d_%H%M%S'
alias datetime_msec='date +%Y%m%d_%H%M%S_%3N'
alias em='emacs -nw'
alias g=git
alias t=tmux
alias pipes='pipes.sh -c 1 -c 2 -c 3 -c 4 -c 5 -c 6 -c 7'
alias blahaj='display3d $HOME/wrk/display3d/resources/blahaj.obj -t 0,0,5.5'
alias yay_='yay --noconfirm && fix-default-browser'
alias erd_='erd -.iH -L 1 --pattern=!/mnt/**/* --glob'
alias zen='zenlog open-log'
alias chrome-mem='ps aux | grep /opt/google/chrome/chrome | awk "{sum += \$6 * 1024}END{print sum}" | numfmt --to=iec-i'

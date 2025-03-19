if status is-interactive
    # Commands to run in interactive sessions can go here
set -x PATH $HOME/.local/bin $HOME/bin $PATH
set -x PATH $HOME/scripts $PATH
set -Ux PATH $PATH /sbin

set -x CMAKE_MAKE_PROGRAM ninja
set -x CC gcc
set -x CXX g++
set -x _ZO_DATA_DIR /home/asdf/zoxide
set -x FZF_DEFAULT_COMMAND "ls -1"
set -x FZF_DEFAULT_OPTS "--layout=reverse --info=inline"
set -x FZF_DEFAULT_OPTS_FILE "$HOME/.fzf_defaults"
set -x TERM xterm-256color
set -x TZ "Asia/Kolkata"
set -x GTK_THEME Adwaita:dark
set -Ux TERMINAL kitty
set -Ux XDG_TERMINAL_EMULATOR kitty
set -gx GTK_THEME "Adwaita"
set -gx GTK_ICON_THEME "Adwaita"
set -x QT_QPA_PLATFORM wayland
set -Ux GDK_BACKEND wayland
set -x QT_QPA_PLATFORM xcb

atuin init fish | source





set fish_greeting ""
alias partitionmanager='sudo -E dbus-launch partitionmanager'
alias ram_usage="smem -t -r  | fzf"
alias kai="source ~/Desktop/ksai/bin/activate"
alias ksai="source /home/asdf/Desktop/ksai/bin/activate.fish"
alias neo="nvim ~/.config/nvim/init.lua"
alias config="cd ~/.config"
alias zeb-duke="blueman-manager"
alias s="source ~/.config/fish/config.fish"
alias c="clear"
alias vi="sudo -E nvim"
alias ls="exa --all"
alias ll="exa -l"
alias la="exa -la"
alias lla="exa -la --git"
alias lt="exa -T"
alias vbash="nvim ~/.config/fish/config.fish"
alias zdata="zoxide edit"
alias diskspace="du -S | sort -n -r | more"
alias remove_with_dependency="sudo pacman -Rns"
alias iinstall="sudo pacman -S"
alias psg="ps aux | grep"
alias ip="ip addr show | grep inet"
alias vv="source ~/Desktop/virtualpy/bin/activate"
alias topcpu="top -o %CPU"
alias topmem="top -o %MEM"
alias watchdisk="watch -n 5 df -h"
alias meminfo="cat /proc/meminfo"
alias qq="list_custom_methods"
alias desktop="cd ~/Desktop"
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias restart="sudo systemctl restart"
alias current_status="sudo systemctl status"
alias enable="sudo systemctl enable"
alias disable="sudo systemctl disable"
alias kernel="uname -r"
alias sysinfo="hostnamectl"
alias uinfo="lsb_release -a"
alias sensors="sensors"
alias back-one="git reset --hard"
alias wifi="sudo nmcli dev wifi list"
alias wifi_status="nmcli connection show"
alias wifi_connect="nmcli dev wifi connect"
alias docker_images="sudo docker images"
alias cd..="cd .."
alias restart="systemctl --user restart dbus"     
function fuck --wraps='thefuck' --description 'Correct the last command'
    set -l last_command (history | head -n 1)
    thefuck $last_command | read -l fixed_command
    if test -n "$fixed_command"
        eval $fixed_command
    end
end

end




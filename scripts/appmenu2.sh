#!/bin/bash
while true; do
    choice=$(printf "List Pacman Packages\nList AUR Packages\nList Core Packages\nList Extra Packages\nSearch Package\nInstall Package\nRemove Package\nUpdate System\nExit" \
        | fzf --prompt="Package Manager > " --height=12)

    case "$choice" in
        "List Pacman Packages")
            pacman -Qn | fzf --prompt="Pacman Installed > " --preview 'pacman -Qi {1}'
            ;;
        "List AUR Packages")
            pacman -Qm | fzf --prompt="AUR Installed > " --preview 'pacman -Qi {1}'
            ;;
        "List Core Packages")
            pacman -Sl core | grep '\[installed\]' | awk '{print $2}' | fzf --prompt="Core Installed > " --preview 'pacman -Qi {}'
            ;;
        "List Extra Packages")
            pacman -Sl extra | grep '\[installed\]' | awk '{print $2}' | fzf --prompt="Extra Installed > " --preview 'pacman -Qi {}'
            ;;
        "Search Package")
            read -p "Enter search term: " term
            yay -Ss "$term" | less
            ;;
        "Install Package")
            read -p "Enter package name: " pkg
            yay -S "$pkg"
            ;;
        "Remove Package")
            pkg=$(pacman -Qe | fzf --prompt="Select to remove > " | awk '{print $1}')
            [ -n "$pkg" ] && yay -Rns "$pkg"
            ;;
        "Update System")
            yay -Syu
            ;;
        "Exit")
            break
            ;;
    esac
done


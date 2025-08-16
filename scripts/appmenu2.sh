#!/bin/bash
while true; do
    choice=$(printf "List Pacman Packages\nList AUR Packages\nList Core Packages\nList Extra Packages\nList Explicitly Installed (Native)\nList Explicitly Installed (AUR)\nList Flatpak Packages\nSearch Package\nInstall Package\nRemove Package\nRemove Flatpak Package\nUpdate System\nExit" \
        | fzf --prompt="Package Manager > " --height=16)

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
        "List Explicitly Installed (Native)")
            pacman -Qent | fzf --prompt="Explicit Native > " --preview 'pacman -Qi {1}'
            ;;
        "List Explicitly Installed (AUR)")
            pacman -Qemt | fzf --prompt="Explicit AUR > " --preview 'pacman -Qi {1}'
            ;;
        "List Flatpak Packages")
            flatpak list --columns=application,version,origin | \
                fzf --prompt="Flatpak Installed > " --preview 'flatpak info {1}'
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
        "Remove Flatpak Package")
            pkg=$(flatpak list --columns=application | fzf --prompt="Select Flatpak to remove > ")
            [ -n "$pkg" ] && flatpak uninstall "$pkg"
            ;;
        "Update System")
            yay -Syu
            ;;
        "Exit")
            break
            ;;
    esac
done


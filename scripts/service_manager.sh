#!/bin/bash

while true; do
    choice=$(printf "List Running Services\nList All Services\nStart Service\nStop Service\nRestart Service\nEnable Service\nDisable Service\nView Service Status\nExit" \
        | fzf --prompt="Service Manager > " --height=12)

    case "$choice" in
        "List Running Services")
            systemctl list-units --type=service --state=running | less
            ;;
        "List All Services")
            systemctl list-unit-files --type=service | less
            ;;
        "Start Service")
            service=$(systemctl list-unit-files --type=service | awk '{print $1}' | grep '\.service$' | fzf --prompt="Select service to start > ")
            [ -n "$service" ] && sudo systemctl start "$service"
            ;;
        "Stop Service")
            service=$(systemctl list-units --type=service --state=running | awk '{print $1}' | fzf --prompt="Select service to stop > ")
            [ -n "$service" ] && sudo systemctl stop "$service"
            ;;
        "Restart Service")
            service=$(systemctl list-units --type=service --state=running | awk '{print $1}' | fzf --prompt="Select service to restart > ")
            [ -n "$service" ] && sudo systemctl restart "$service"
            ;;
        "Enable Service")
            service=$(systemctl list-unit-files --type=service | awk '{print $1}' | grep '\.service$' | fzf --prompt="Select service to enable > ")
            [ -n "$service" ] && sudo systemctl enable "$service"
            ;;
        "Disable Service")
            service=$(systemctl list-unit-files --type=service | awk '{print $1}' | grep '\.service$' | fzf --prompt="Select service to disable > ")
            [ -n "$service" ] && sudo systemctl disable "$service"
            ;;
        "View Service Status")
            service=$(systemctl list-unit-files --type=service | awk '{print $1}' | grep '\.service$' | fzf --prompt="Select service to view status > ")
            [ -n "$service" ] && systemctl status "$service"
            ;;
        "Exit")
            break
            ;;
    esac
done


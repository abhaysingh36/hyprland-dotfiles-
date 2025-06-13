function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M default \cb "commandline | wl-copy"  # Changed from \ca to \cb
end

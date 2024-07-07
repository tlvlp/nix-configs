# NixOS Configs

Config for NixOS with Flakes

## Reminder: ownership under /etc/nixos

```sh
drwxr-xr-x user users .git/
-rw-r--r-- root root  configuration.nix <---- all configs and flakes still owned by root
-rwxr-xr-x user users pu.sh*
```

## Todo

- BT fix at startup
- zsh + nix terminal w/ nix config
- How to run RustRover and Intellij (flakes? or just give write access)
- How to install steam + gaming related drivers?
- Configure docker (only for flakes?)
- Add Gruvbox dark medium theme to os
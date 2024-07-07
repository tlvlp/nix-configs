# NixOS Configs

Config for NixOS with Flakes

## Reminder: ownership under /etc/nixos

```sh
drwxr-xr-x user users .git/
-rw-r--r-- root root  configuration.nix <---- all configs and flakes still owned by root
-rwxr-xr-x user users pu.sh*
```


# NixOS Configs
Config for NixOS with Flakes

## Config Structure
`flake.nix` is the main entrypoint of all the other configs
    ├── `configurations.nix` for the classic, channel-based system configs.
    |       ├── `home.nix` for all the home directory stuff, eg. user-specific packages.
    |       └── `hardware-configuration.nix` auto-generated, for the hw-specific stuff (git-ignoring it breaks the build..) 
    └── `flake.lock` auto-generated with all dependency versions under `flake.nix`.

## How to update
Once the changes are saved, use the [pu.sh](pu.sh) script with a commit message as argument, or left blank for just bumping. 
It will build and deploy the new os, then push the changes to the git remote.
```sh
./pu.sh "Add motivational cowsay."
```


## Reminder: ownership rules under /etc/nixos to work well with git

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
# NixOS Configs

Configs for NixOS with a standalone Home-manager.

## Package search

[NixOS](https://search.nixos.org/packages)
[MyNixOS](https://mynixos.com/packages)

## Fresh install: Create symlinks

```sh
# System configs
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix-backup
sudo ln -s $(pwd)/configuration.nix /etc/nixos/configuration.nix
# Home-manager
mv ~/.config/home-manager/ ~/.config/home-manager-backup
mkdir ~/.config/home-manager/
ln -s $(pwd)/flake.nix ~/.config/home-manager/flake.nix
ln -s $(pwd)/flake.lock ~/.config/home-manager/flake.lock
ln -s $(pwd)/home.nix ~/.config/home-manager/home.nix
```

## Daily use

### Deploy all Home-manager changes

```sh
home-manger swtich
```

### Update packages

Need to be run in this repo's dir.

```sh
nix flake update\
&& home-manager switch
```

### Run garbage collector

```sh
nix-collect-garbage
```

### OS Rebuild

Only required if the `configuration.nix` changes.

```sh
sudo nixos-rebuild switch
```

If it complains about :
> Nixos-config not found in Nix search path

Use the explicit path (that also fixes the default value)

```sh
sudo nixos-rebuild switch -I nixos-config=/etc/nixos/configuration.nix
```

## Todo

- Add Gruvbox dark medium theme to os
- How to run RustRover and Intellij (flakes? or just give write access)
- How to install steam + gaming related drivers?
- Configure docker (only for flakes?)

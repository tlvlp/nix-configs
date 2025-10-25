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
&& home-manager switch\
&& nixos-rebuild switch --upgrade --impure --flake .#tlvlp
```


### Upgrade the OS version

Add the channel of the new OS version, e.g.:
```
nix-channel --add https://channels.nixos.org/nixos-25.05 nixos
```

See https://nixos.org/manual/nixos/stable/index.html#sec-upgrading

### Run garbage collector

```sh
nix-collect-garbage
```

### OS Rebuild

Only required for:

- Changes in `configuration.nix`.
- Changes in `flake.nix`.
- OS version/channel update

> Note the --impure flag is required as the hardware-config in the configuration.nix is referenced externally
(as it belongs to the machine) and it goes agains the purity rules of Flakes.

```sh
nixos-rebuild switch --impure --flake .#tlvlp
```

If it componlylains about : `Nixos-config not found in Nix search path` use the explicit path (that also fixes the default value)

```sh
nixos-rebuild switch --impure --flake .#tlvlp -I nixos-config=/etc/nixos/configuration.nix
```

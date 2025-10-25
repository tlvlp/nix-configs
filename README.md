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
Note that a `nixos-rebuild` or a `nix-store --verify` might be needed in some cases (see related sections).

```sh
nix flake update\
&& home-manager switch\
```

### Upgrade the OS version

Add the channel of the new OS version, e.g.:

```sh
nix-channel --add https://channels.nixos.org/nixos-25.05 nixos
```

Update the OS version in `home.nix`, `flake.nix` and `configuration.nix`

See https://nixos.org/manual/nixos/stable/index.html#sec-upgrading

### OS Rebuild

Only required for:

- Changes in `configuration.nix`.
- Changes in `flake.nix`.
- OS version/channel update

> Note the --impure flag is required as the hardware-config in the configuration.nix is referenced externally
(as it belongs to the machine) and it goes agains the purity rules of Flakes.

```sh
sudo nixos-rebuild switch --impure --flake .#tlvlp
```

If it componlylains about : `Nixos-config not found in Nix search path` use the explicit path (that also fixes the default value)

```sh
sudo nixos-rebuild switch --impure --flake .#tlvlp -I nixos-config=/etc/nixos/configuration.nix
```

### Fix packages

```sh
nix-store --verify --check-contents --repair
```

### Run garbage collector

Cleans up all the unused / redundant downloads.

```sh
nix-collect-garbage
```

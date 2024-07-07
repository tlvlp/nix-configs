#!/bin/sh

echo "Rebuilding Nixos"
sudo nixos-rebuild switch --flake .#default\
&& echo "Pushing changes to origin"\
&& git add .\
&& git commit -m "${1:-bump}"
# && git push origin main

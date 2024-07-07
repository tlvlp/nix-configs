#!/bin/sh


echo "Rebuilding Nixos"
sudo nixos-rebuild switch --flake .#default\
&& echo "Pushing changes to origin"\
&& if [ -z "$1" ]; then echo "Commit message was not set, using default!"; fi\
&& git add .\
&& git commit -m "${1:-bump}"
&& git push origin main

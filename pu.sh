#!/bin/sh
# Note: `sudo echo` is used as a workaround, since nom swallows the sudo password prompt. 
sudo echo "Rebuilding Nixos" 
sudo nixos-rebuild switch --flake .#default |& nom --json\
&& echo "Pushing changes to git origin"\
&& if [ -z "$1" ]; then echo "Commit message was not set, using default!"; fi\
&& git add .\
&& git commit -m "${1:-bump}"\
&& git push origin main

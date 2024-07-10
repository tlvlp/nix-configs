#!/bin/sh

echo "Deploying Home-Manager changes." 
home-manager switch\
&& echo "Pushing changes to git origin"\
&& git add .\
&& if [ -z "$1" ]; then echo "Commit message was not set, using default!"; fi\
&& git commit -m "${1:-bump}"\
&& git push origin main

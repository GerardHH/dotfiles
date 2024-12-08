# Portable development environment
This repo is my personal development environment which means it will not work for you when using this setup. However, feel free to use this repo as a source of inspiration.
## Dependancies
See `util/Dockerfile` and `util/pre_installed.Dockerfile` for all details, but here is a summary:
* build-essential
* curl
* git
* gpg (for encryption, currently installs fullblown linux distro through brew)
* procps
Testing:
* podman
Optional (`util/setup.sh` will install rootlessly if missing):
* homebrew 
* bitwarden-cli
## Setup
To unluck bitwarden, which is used to guard secrets, login to `https://vault.bitwarden.com`. Go to `Settings -> Security -> Keys -> API Key -> View API key`. Take the `client_id` and `client_secret` and populate `BW_CLIENTID` and `BW_CLIENTSECRET` environment variables.
Download `util/setup.sh` and execute. Use `util/validate.sh` to see if the setup was successful. 

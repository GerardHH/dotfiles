# Portable development environment
This repo is my personal development environment. If the secrets cannot be decrypted, they will be skipped, which means some things might not work out of the box like the git configs that are included by `.gitconfig`. However, feel free to use this repo as a source of inspiration.
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
Download `bootstrap.sh` and execute. Use `util/validate.sh` to see if the setup was successful. 
The decryption uses GPG and requires to have a `.env` file available with the correct secrets setup, use `util/setup_secrets.sh` which uses bitwarden to setup the file.

# Portable development environment
This repo is my personal development environment. If the secrets cannot be decrypted, they will be skipped, which means some things might not work out of the box like the git configs that are included by `.gitconfig`. However, feel free to use this repo as a source of inspiration.
## Dependancies
See `util/container/Dockerfile` for all details, but here is a summary:
* build-essential
* curl
* git
* gpg
* homebrew
* procps
* xclip
Testing:
* podman
## Setup
Download `bootstrap.sh` and execute. Use `automation/validate.sh` to see if the setup was successful.
## Secrets
The decryption uses GPG and requires to have a `.env` file available with the correct secrets setup, use `util/setup_secrets.sh` which uses bitwarden to setup the file.
Note that `GPG_PRIVATE_KEY` is encoded using `base64 --wrap=0` so that it can be passed around in environment variables.

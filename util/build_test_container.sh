set -ex

REPO_PATH="${REPO_PATH:-$HOME/.local/share/chezmoi}"

podman build -t dotfiles-test:latest $REPO_PATH/util

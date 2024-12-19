set -ex

REPO_PATH="${REPO_PATH:-$HOME/.local/share/chezmoi}"

podman build -t dotfiles-test:latest $REPO_PATH -f util/Dockerfile
podman build -t dotfiles-pre-installed-test:latest $REPO_PATH -f util/pre_installed.Dockerfile

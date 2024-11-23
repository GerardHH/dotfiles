set -ex

TEST_PATH="${TEST_PATH:-$HOME/.local/share/chezmoi/test}"

podman build -t dotfiles-test:latest $TEST_PATH

podman images

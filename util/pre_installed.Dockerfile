FROM dotfiles-test

USER root

# Create homebrew folder and make it available for testuser
WORKDIR /home/linuxbrew/.linuxbrew
RUN chown testuser:testuser /home/linuxbrew/.linuxbrew && chmod u+w /home/linuxbrew/.linuxbrew

# Install homebrew as testuser
USER testuser
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install additional dependencies
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; HOMEBREW_NO_ENV_HINTS=1 brew install \
	bitwarden-cli

# Switch working directory back to testuser
WORKDIR /home/testuser

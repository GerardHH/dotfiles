FROM dotfiles-test

# Create homebrew folder and make it available for testuser
USER root
WORKDIR /home/linuxbrew/.linuxbrew
RUN chown testuser:testuser /home/linuxbrew/.linuxbrew && chmod u+w /home/linuxbrew/.linuxbrew

# Install homebrew as testuser
USER testuser
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Switch working directory back to testuser
WORKDIR /home/testuser

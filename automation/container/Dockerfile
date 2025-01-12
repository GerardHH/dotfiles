FROM debian:latest

RUN apt update && apt upgrade && apt install -y \
    build-essential \
    curl \
    fontconfig \
    git \
    gnupg \
    procps \
    xclip \
    && apt clean

# Create homebrew folder and make it available for testuser
WORKDIR /home/linuxbrew/.linuxbrew
RUN useradd -m testuser && chown testuser:testuser /home/linuxbrew/.linuxbrew && chmod u+w /home/linuxbrew/.linuxbrew

USER testuser
WORKDIR /home/testuser
ENV HOME=/home/testuser

#Simulate existing folders
RUN mkdir .config
RUN mkdir .ssh && chmod 700 .ssh

# Install homebrew as testuser
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install additional dependencies
# RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; HOMEBREW_NO_ENV_HINTS=1 brew install

COPY ../../bootstrap.sh .

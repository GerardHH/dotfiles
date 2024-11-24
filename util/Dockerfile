FROM debian:latest

# Install dependancies
RUN apt-get update && apt-get install -y \
	build-essential \
	curl \
	git \
	procps \
	&& apt-get clean

# Setup test user
RUN useradd -m testuser
USER testuser
WORKDIR /home/testuser
ENV HOME=/home/testuser

COPY \
	setup.sh \
	source_brew.sh \
	validate_environment.sh \
	/home/testuser

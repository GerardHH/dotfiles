FROM debian:latest

# Install dependancies
RUN apt-get update && apt-get install -y \
	git \
	&& apt-get clean

# Setup test user
RUN useradd -m testuser
USER testuser
WORKDIR /home/testuser
ENV HOME=/home/testuser

COPY validate_environment.sh /home/testuser

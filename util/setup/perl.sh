#!/bin/bash

if ! command -v cpanm; then
    echo "No cpanm found, insalling..."
    brew install cpanm
fi

cpanm IPC::Cmd

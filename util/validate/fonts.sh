#!/bin/bash

if ! command fc-list; then
    echo "Error: Could not find fc-list"
    exit 1
fi

if  ! fc-list | grep "Hack" ; then
    echo "Error: Hack Nerd Font not found"
    exit 1
fi

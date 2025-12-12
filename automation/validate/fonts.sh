#!/bin/bash

if ! command fc-list; then
    log_error "Could not find fc-list"
    exit 1
fi

if  ! fc-list | grep "Hack" ; then
    log_error "Hack Nerd Font not found"
    exit 1
fi

#!/bin/bash

#### For VirtualBox ####
# pkill vmtoolsd 2> /dev/null
# vmtoolsd -n vmusr
#
# VBoxClient --clipboard


#### For VMware ####
# Kill the existing user-space tools daemon
pkill vmtoolsd 2> /dev/null

# Restart the user-space daemon explicitly
# This handles clipboard, drag-and-drop, and resolution changes
vmtoolsd -n vmusr &

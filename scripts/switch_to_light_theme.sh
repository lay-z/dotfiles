#!/bin/bash

CONFIG_FILE=~/.config/alacritty/alacritty.toml

cat $CONFIG_FILE | sed -u 's/mocha/latte/g' | tee $CONFIG_FILE

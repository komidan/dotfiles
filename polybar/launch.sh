#!/usr/bin/env bash

# kill active instance
polybar-msg cmd quit

# nuclear option !
# killall -q polybar

echo "---" | tee -a /tmp/polybar1.log
polybar bar 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bars Launched..."

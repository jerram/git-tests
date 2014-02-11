#!/bin/bash
HOOK_DIR=$(git rev-parse --show-toplevel)/.git/hooks
# here are the repo hooks you want to install
FILES=$(git rev-parse --show-toplevel)/hooks/*
HOOKS=hooks

for hook in $FILES; do
    # If the hook already exists, is executable, and is not a symlink
    if [ ! -h $HOOK_DIR/$hook -a -x $HOOK_DIR/$hook ]; then
        mv $HOOK_DIR/$hook $HOOK_DIR/$hook.local
    fi
    # create the symlink, overwriting the file if it exists
    # probably the only way this would happen is if you're using an old version of git
    # -- back when the sample hooks were not executable, instead of being named ____.sample
    echo "n -s -f $hook $HOOK_DIR/`basename $hook`"
done
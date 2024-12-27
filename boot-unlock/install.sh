#!/usr/bin/env bash

# As defined in man 5 systemd.unit
target=/etc/systemd/system

install -o root -g root -m 644 zfs-load-key@.service $target


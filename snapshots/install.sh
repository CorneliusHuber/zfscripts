#!/usr/bin/env bash

# As defined in man 5 systemd.unit
target=/etc/systemd/system

# Snapshot taker
install -o root -g root -m 644 snapshot-daily@.timer $target
install -o root -g root -m 644 snapshot-weekly@.timer $target
install -o root -g root -m 644 snapshot-monthly@.timer $target

install -o root -g root -m 644 snapshot-daily@.service $target
install -o root -g root -m 644 snapshot-weekly@.service $target
install -o root -g root -m 644 snapshot-monthly@.service $target

# Snapshot destroyer
install -o root -g root -m 644 snapshot-destroy.timer $target
install -o root -g root -m 644 snapshot-destroy.service $target

# Test files
install -o root -g root -m 644 snapshot-test@.timer $target
install -o root -g root -m 644 snapshot-test@.service $target

systemctl daemon-reload

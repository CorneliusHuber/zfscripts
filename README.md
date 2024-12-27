# zfscripts
Scripts and systemd units I use to manage ZFS on my systems.

## Folders:

### Timers
Requirements: `systemd`, `zfsnap`

`cat snapshot-daily@.service`:
```
[Unit]
Description=Does the daily snapshot.

[Service]
Type=oneshot
StandardOutput=journal
StandardError=journal
ExecStart=zfsnap snapshot -a2w -p zfsnap %I
```

Time to live can be changed by tweaking the value in the `-a` option.

run `install.sh` to put the timers and services in place.
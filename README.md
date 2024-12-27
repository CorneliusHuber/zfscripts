# zfscripts
Scripts and systemd units I use to manage ZFS on my systems.

## Folders:

### Timers
#### Requirements:

`systemd`, `zfsnap`

#### Activation

Run `install.sh` to put the timers and services in place. Activate with `systemctl enable snapshot-daily@partition-to-snapshot.timer`.

#### Livespan

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


### ZFS unlock script
Unlocks encrypted zfs filesystems at boot time with systemd-ask-password. All datasets with this password are unlocked. Activate with `systemctl enable zfs-load-key@partition-to-unlock`. Slashs in folders`/` are escaped as `-`.


### ZFS encryption Benchmark
This software tests all the currently available zfs encryption algorithms on how fast they are by creating a new dataset and copying files onto it. You can select the algorithms you want to test, and also need to set the folder which you want to copy onto your datasets.


#### Requirements (Tested on Ubuntu)
 - zfsutils-linux
 - zfs-initramfs
 - zsh
 - rsync


#### Configuration
The algorithms which are benchmarked are listed in the file `config/algorithms`. For the ease of writing this script, every new algorithm needs to be a new word. It does not need to be on a new line, it makes things easier on the eyes however.
You can select ONE path to a folder, relative to your home directory in the file `config/copy_folder`, you will need to do this yourself. I personally just symlink the folder I want to copy into the location specified in this file.


#### Usage
First of all, configure your software. For this, see the point above, `Configuration`. As the first argument you have to set the name of youre pool. If this is not set, the benchmark will not succed. As the second argument you may add the option `--create_pw_file`, which forces to create a new password file.

    ./benchmark <pool name> [--create_pw_file]




#### Use cases
 - Theoretical I/O your CPU can handle over time. For this you might want to create a ZFS pool in a RAMdisk.
 - Benchmarking the load of encrypting your data onto your system.
 - Theoretically also benchmarking the I/O speed in your pool, even though not this script was not intended for this use. To do this, add a line `off` into the `config/algorithms` file.
Feel free to contact me if you have an interesting use case you might want to consider.


#### Caveats
If you have a dataset that is named `<encryption algorithm>_zfs_benchmark` it will be destroyed after the benchmark. I can not imagine someone actually having that name in production, so I did not take the lenghts to add a protection feature. You are warned, use it at your own risk.

#### Todo:
 - [ ] When a dataset could not be created, exit. There could be that theoretical case where information might be lost.
 - [ ] Only destroy datasets after the benchmark which have actually been created.
 - [ ] Destroy datasets right after the benchmark, or at least clear them, for use in RAM disks.
 - [ ] Try out benchmark with hardware acceleration.
 - [ ] Automatically generate a symlink to /home/user/documents_folder


#!/usr/bin/env bash

date
df    # disk free
free  # -
exit


# Linux has one filesystem across all attached devices. Devices are mounted

cd -          # change to previous working dir
cd ~user_name # change to user_name's home dir

ls dir1 dir2  # list contents of 1+ dirs
ls -A         # doesn't list the . and ..

file file_name   # file type info
# Everything in Unix is a file

cd /bin   # binaries for boot and run
cd /boot  # linux kernel (not on mac)
cd /dev   # device nodes registered with the kernel
cd /etc   # configs and shell scripts for boot time (interesting ones (not on mac): crontab, fstab, passwd)

cd /usr   # user programs and their support files

cp *.html DEST           # batch copy files
cp --recursive dir1 DEST # copy dir1 AND it's contents
mkdir dir1 dir2...       # make multiple dirs


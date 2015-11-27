
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
ls -i         # Print the inode no. in the first field. inode no. is used to verify if any 2 files/hardlinks are the same

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

rm *.html   # tip: Check the wildcard with ls first before using rm !

ln -s origFile link  # symbolic link

type command_name   # Info about the type (binary, script, alias) of the command
which command_name  # Gives the location of the command
help command_name   # help for built-in commands
apropos search | man -k search   # Propose a list of commands matching search

> FILE                # Empty out existing file or create new file
ls /usr/bin >> FILE   # Append output to FILE (safer than '>' as you won't accidently empty out FILE)
ls /badfolder 2> ERRORFILE  # Explicitly redirect error msg to ERRORFILE. stderror has file descriptor 2

ls /usr/bin > FILE 2>&1 # Redirects stdout and stderror to FILE. Reading from right to left stderror to stdout, then stdout to FILE
ls /usr/bin &> FILE     # shorthand for above

ls /badfolder 2> /dev/null  # Dump error msgs by redirecting stderror to the bit bucket

cat >> FILE  # Redirect stdin (keyboard) to FILE (Ctrl + d to end stdin)
cat < FILE  # Get input from FILE


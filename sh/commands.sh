
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

sort | uniq | grep | head | tail   # stdout filters

ls /usr/bin | tee FILE # Outputs to both FILE and stdout

##### EXPANSION #####

echo *      # Here '*' gets expanded into a list of files in the pwd
echo ~/projects/*/test  # Finds test subfolders in all projects

echo $( (2+2) )     # Arithmetic expansion
echo $( (5**2) )    # 5 to the power of 2

echo start-{A,B}-end     # Expands to: start-A-end start-B-end
echo start-{1..3}-end    # Expands to: start-1-end start-2-end start-3-end
echo start-{01..3}-end   # Expands to: start-01-end start-02-end start-03-end
echo {2010..2015}-{01..12}  # Eg. To expand to a list a dates

# Cmd substitution $() OR ``
ls -l $(which cp)   # Expands 'which cp' to feed path of 'cp' into outer cmd 'ls -l'

echo "$(cal)"  # Double quotes prevents word splitting (ie. prevents intepretation of spaces as cmd argument delimiters)
echo $(cal)    # compare output with above. Notice that all spaces are intepreted as arg delimiter

# Note the decreasing level of expansion in the following. unquoted, double quoted, single quoted
echo text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER      # Gives: text /home/me/ls-output.txt a b foo 4 me
echo "text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER"    # Gives: text ~/*.txt {a,b} foo 4 me
echo 'text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER'    # Gives: text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER

# History
history     # list cmd history
history -c  # clear
!!          # Run last cmd
!string     # Run last cmd starting with {string}
!num        # Run cmd at {num}
!?string    # Run last cmd containing {string}

# vi cmd (normal) mode
:q! # force exit
w   # move fwd a word inc. punctuation
b   # move back a word inc. punctuation
ctrl+f  # page down
ctrl+b  # page up
u   # undo

# vi edit (insert) mode

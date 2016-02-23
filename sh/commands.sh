
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

wc -l FILE  # line count from stdin or FILE

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

##### REDIRECTION ###################################################################################

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

##### EXPANSION ####################################################

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

##### History ####################################

history     # list cmd history
history -c  # clear
!!          # Run last cmd
!string     # Run last cmd starting with {string}
!num        # Run cmd at {num}
!?string    # Run last cmd containing {string}

##### VIM ########################################

# vim cmd (normal) mode
:q! # force exit
w   # move fwd a word inc. punctuation
b   # move back a word inc. punctuation
ctrl+f  # page down
ctrl+b  # page up

u   # undo

A   # Start appending to the end of the line
o   # Insert new line

dd      # Cut line
5dd     # Cut 5 lines
dw      # Cut word
x       # Cut char

y       # Copy

p       # Paste

J       # Join line

/word       # Find word in file
n           # Find next occurrence

:%s/search/replace/gc   # Find and replace text in file. % means whole file. g = global, c = confirm? / can be _

ZZ      # Save and Exit
:wq     # same as above
:w newName  # Saves file as newName

# Editor configs. Add these to ~/.vimrc
syntax on       # Enables syntax colors OR :set syntax=sh
set autoindent
set tabstop=4

##### Prompt customization ########################################################################################

PS1=\[\033[0;32m\]$?\[\033[0m\] \[\033[1;35m\]\u\[\033[0m\]: \[\033[1;35m\]\W\[\033[0m\] \[\033[1;92m\]\[\033[0m\]$

##### Searching for files ###################################################################################

locate FILENAME     # locates the filename from an internal database (index) which needs to be updated frequently

find DIR            # finds all files under DIR recursively

# Tests
find DIR -type d    # finds files testing for type where d = directory, f = file, l = symbolic links
find DIR -type f -name '*.jpg' -size +1M    # finds files testing for name and size (+ means gt, - means lt)

# More tests available in man find !

# Operators
find DIR \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)    # example of 2 expression groups and using -or

##### RegEx ###############################

grep -E EXPRESSION  # -E allows all metacharacters to be used without escaping them with '\'.

##### sed #################################

# search and replace
sed -E -i bak -e 's_REGEX1_REPLACE1_' -e 's_REGEX2_REPLACE2_' FILE.txt
# "-i bak" writes backup to FILE.txtbak and changes to FILE.txt
# -e for multiple search and replace cmds

sed -E 's_(group1)_&\1_g' FILE.txt
# group1 is referred to as "\1". The whole match is referred to as "&"
# Flag "g" will replace all matches on a line

##### Scripting ##############################

# Make sure my script is executable
chmod 755 MY_SCRIPT     # everyone can execute OR 700 only owner can execute

# Make sure my script can be found by shell
echo $PATH     # check the execution paths
export PATH=MY_NEW_PATH:"$PATH"   # Add my new path to the existing path in ~/.bashrc

. ~/.bashrc       # Reloads ~/.bashrc
source .bashrc  # same as above

# Variables
myVar='value'
$myVar     # simple var usage

someVar='dog'
dog1='john'
${someVar}1  # complex var expansion. gives dog1

# 'Here document' (file input redirection)
# inside a here documents, single and double quotes are printed as literals which could be more intuitive
cat <<- _EOF_   # '-' means ignore tabs. _EOF_ can be any token to mark the start and end of the file
<xml>
    <tag1>$myVar</tag1>
    <tag2>$dog1</tag2>
</xml>
_EOF_

# This prints similar output to the above here document, but using 'echo'
echo "<xml>
    <tag1>$myVar</tag1>
    <tag2>$dog1</tag2>
</xml>"

###### Flow control ###############################
# if [commands]; then elif .. else .. fi
# commands can be composed of file/string/integer expressions (pg 384)

if [ $x -eq 5 ]; then   # integer expression
    echo 'x equals 5'
elif [ $x == 'five' ]; then  # string expression
    echo 'x equals five'
else
    echo 'x is something else'
fi


if [[ string =~ regex ]] # regex test (pg 389)

if (( $x > 2)) # explicit integer operation

# Exit status
# 0|true is success, 1|false is failure
$?  # returns current exit status

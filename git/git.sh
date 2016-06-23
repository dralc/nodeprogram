#Get the current branch
currentBranch=$(git symbolic-ref --short HEAD)

# You can checkout files/dirs from another local or remote branch
git checkout branchRef -- file1ToCopy.js file2ToCopy.css

# List your repo's configuration
git config -l


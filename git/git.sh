#Get the current branch
currentBranch=$(git symbolic-ref --short HEAD)

# You can checkout files/dirs from another local or remote branch
git checkout branchRef -- file1ToCopy.js file2ToCopy.css

# List your repo's configuration
git config -l

# Clone a specific branch only
git clone URL --branch branchName --single-branch myFolder

# Shallow clone 1 level of commits
git clone --depth 1 -- repoUrl ./myDir

# List all files changed between two commits
# - http://stackoverflow.com/questions/3144647/git-show-all-files-changed-between-two-commits
git log --name-only --pretty=oneline --full-index SHA-1A..SHA-1B |grep --invert-match --extended-regexp '^[0-9a-f]{40} ' |sort |uniq

git diff --stat SHA-1A SHA-1B

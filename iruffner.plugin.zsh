

#   -------------------------------
#   1. MAKE TERMINAL BETTER
#   -------------------------------

alias cp='cp -iv' # Preferred 'cp' implementation
alias mv='mv -iv' # Preferred 'mv' implementation
alias mkdir='mkdir -pv' # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp' # Preferred 'ls' implementation
alias less='less -FSRXc' # Preferred 'less' implementation
alias cd..='cd ../' # Go back 1 directory level (for fast typers)
alias ..='cd ../' # Go back 1 directory level
alias ...='cd ../../' # Go back 2 directory levels
alias .3='cd ../../../' # Go back 3 directory levels
alias .4='cd ../../../../' # Go back 4 directory levels
alias .5='cd ../../../../../' # Go back 5 directory levels
alias .6='cd ../../../../../../' # Go back 6 directory levels
alias edit='code -w' # edit:         Opens any file in vscode editor
alias f='open -a Finder ./' # f:            Opens current directory in MacOS Finder
alias c='clear' # c:            Clear terminal display
alias which='which -a' # which:        Find executables
alias DT='tee ~/Desktop/terminalOut.txt' # DT:           Pipe content to file on MacOS Desktop

function cd () {
    builtin cd $argv[1]
    ll
}

function mcd () {
    mkdir -p $argv[1]; and cd $argv[1]
}

function trash () {
    command mv $argv[1] ~/.Trash
}

function ql () {
    qlmanage -p $argv[1] >&/dev/null
}

function configEdit () {
    code $ZSH/custom/plugins/iruffner/iruffner.plugin.zsh
}

function configReload () {
    source $ZSH/oh-my-zsh.sh
}

function cdo () {
    builtin cd $argv[1]
}

function psgrep () {
    ps up (pgrep -f $argv[1]) 2>&-
}

function whichPort () {
    sudo lsof -i -P | grep LISTEN | grep :$argv
}

#   -------------------------------
#   2. FILE AND FOLDER MANAGEMENT
#   -------------------------------

# delete all the .DS_Store files in current directory and sub-directories
function killDS_StoreFiles () {
    find . -name '.DS_Store' -type f -delete
}

# zipf:         To create a ZIP archive of a folder
function zipf () {
    echo "Creating zip file named $argv[1].zip from directory $argv[1] in the current directory"
    zip -r $argv[1].zip $argv[1]/
}

alias numFiles="echo $(ls -1 | wc -l) non-hidden files in current directory" # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat' # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat' # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat' # make10mb:     Creates a file of 10mb size (all zeros)

#   ---------------------------
#   3. SEARCHING
#   ---------------------------

alias qfind="find . -name " # qfind:    Quickly search for file

# ff:       Find file under the current directory
function ff () {
    /usr/bin/find . -name $argv
}

# ffs:      Find file whose name starts with a given string
function ffs () {
    /usr/bin/find . -name $argv'*'
}

# ffe:      Find file whose name ends with a given string
function ffe () {
    /usr/bin/find . -name '*'$argv
}

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
function spotlight () {
    mdfind "kMDItemDisplayName == '$argv'wc"
}

#   ---------------------------
#   4. DEVELOPER-FOO
#   ---------------------------

#update branch list
alias gitbranchcleaner="git remote update origin --prune"
#git status on the current directory
alias gstat="git status"
#all git branches
alias gba="git branch -a"
#switch to the code/expr directory
alias expr="cdo ~/code/expr"
alias eserver="cdo ~/code/expr/emssa"
alias eclient="cdo ~/code/expr/emssa-client"
alias mvcr="cdo ~/code/expr/mvcr"
alias buildAndRun="npm run build; npm run start-local"
alias checkoutDevelopAndCleanBranches="git checkout develop; git pull; gitbranchcleaner"

#perform a gitup on all 
function gitup () {
    for subdir in $(pwd)/*; 
        do
            if [ -d $subdir ]; then
                echo ""
                echo "-------------------------------------------"
                echo "$subdir"
                git -C $subdir pull
            fi
        done
}

#perform a npm i on all 
function npmInstallup () {
    local currentDirectory=$(pwd)
    for subdir in $(pwd)/*; 
        do
            if [ -d $subdir ]; then
                echo ""
                cdo "$subdir"
                echo "-------------------------------------------"
                echo "$(pwd)"
                npm i
            fi
        done
    cdo $currentDirectory
}

#perform a npm audit fix on all 
function npmAuditFixup () {
    local currentDirectory=$(pwd)
    for subdir in $(pwd)/*; 
        do
            if [ -d $subdir ]; then
                echo ""
                cdo "$subdir"
                echo "-------------------------------------------"
                echo "$(pwd)"
                npm audit fix
            fi
        done
    cdo $currentDirectory
}
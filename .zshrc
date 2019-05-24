#####################################################
# On new machine, import existing dotfiles:
# https://www.atlassian.com/git/tutorials/dotfiles 
#####################################################
##
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/leo/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	colored-man-pages
	colorize
	#conda
	#debian
	docker
	#django
	#extract
	#git
	#gradle
	history
#	h
	jump
	#npm
	#node
	#pip
	#pyenv
	python # https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/python
	tmux
	tmuxinator
	sudo
	zsh-completions
	zsh_reload
	z
	#zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Kitty shell completion for zsh
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias x="exit"
alias sz="source ~/.zshrc"
alias zshrc="nvim ~/.zshrc"
alias i3c="nvim ~/.config/i3/config"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias octave='octave-cli'
alias py='ipython'
# "sudo -i" does the same
alias root='sudo su -'

# Kitty terminal aliases
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"
alias gitdiff="git difftool --no-symlinks --dir-diff"
alias light="kitty_theme light"
alias dark="kitty_theme dark"

# colored cat
alias ccat='pygmentize -g'

# Show only dotfiles
alias l.="ls -d .*"
alias ll="ls -lG"
# Confirm when copying, linking, moving
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
# Show free space on filesystems
alias df='df -H'
alias du='du -ch'
alias du1='du -d 1'
# Progress bar on file copy 
alias cpProgress="rsync --progress -ravz"
# Network speed
alias speed='speedtest-cli --server 2406 --simple'
# External IP
alias ipe='curl ipinfo.io/ip'
# Internal IP
alias ipi='ipconfig getifaddr en0'
# Clear screen (also CMD+L)
alias c='clear'
# NordVPN
alias vpn='nordvpn status'
# Increase volume 10% (Goes above max alloted by Gnome)
alias volup='pactl -- set-sink-volume 0 +10%'
# Edit mtrack (trackpad driver for ubuntu)
alias mtrack='sudo vi /usr/share/X11/xorg.conf.d/50-mtrack.conf'

alias sha='shasum -a 256'
alias untar='tar -zxvf'
alias mountlinux="sudo ext4fuse /dev/disk0s4 ~/tmp/LINUX_PARTITION -o allow_other"

alias ju="jump"
alias ma="marks"
alias config='/usr/bin/git --git-dir=/Users/leo/.osx_cfg/ --work-tree=/Users/leo'

alias backupleo="caffeinate -s rsync -aH --delete --info=progress2 /Users/leo /Applications /Volumes/MacbookPro-leo"
alias backupall='sudo rsync -azPH --delete / --exclude={"/home/leo/NAS/*","/snap","/home/leo/.cache/*","/home/leo/MEGA/*","/home/leo/MEGAsync/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} leo@192.168.1.82:/media/2TB_crypt/ubuntu_leo/rsync'
alias backuphome='rsync -azPH --delete /home/leo --exclude={"leo/NAS/*","leo/.cache/*","leo/MEGA/*","leo/MEGAsync/*"} leopi:/media/2TB_crypt/ubuntu_leo/rsync'
alias NAS="sshfs -o IdentityFile=/home/leo/.ssh/id_rsa leo@192.168.1.82:/media/2TB_crypt/ubuntu_leo ~/NAS"

# Tor
alias starttor='service tor start'
alias stoptor='service tor stop'
alias services='service --status-all'

# Python Aliases
alias venvnew='python3 -m venv venv'
alias venv='source venv/bin/activate'

export PATH=$PATH:"/home/linuxbrew/.linuxbrew/bin"
export PATH=$PATH":$HOME/.cargo/bin"
export PATH=$PATH":$HOME/.local/bin"
alias config='/usr/bin/git --git-dir=/home/leo/.cfg/ --work-tree=/home/leo'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

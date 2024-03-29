# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.cache}
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/zsh/custom"

#ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="spaceship"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  copypath
  copyfile
  copybuffer
  dirhistory
  history
  z
  bgnotify
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

plugins+=(zsh-vi-mode)
source $ZSH_CUSTOM/zsh-vi-mode/zsh-vi-mode.plugin.zsh

zvm_after_init() {
  FZF_SHARE=/usr/share/fzf
  [ -f $FZF_SHARE/completion.zsh ] && . "$FZF_SHARE/completion.zsh"
  [ -f $FZF_SHARE/key-bindings.zsh ] && . "$FZF_SHARE/key-bindings.zsh"
}

# Load all files from .shell/rc.d directory
if [ -d $HOME/.shellrc/rc.d ]; then
  for file in $HOME/.shellrc/rc.d/*.sh; do
    source $file
  done
fi

# Load all files from .shell/zshrc.d directory
if [ -d $HOME/.shellrc/zshrc.d ]; then
  for file in $HOME/.shellrc/zshrc.d/*.zsh; do
    source $file
  done
fi
export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]] ;then
  export PINENTRY_USER_DATA="USE_CURSES=1"
fi


[ -f ~/.env ] && source ~/.env

alias luamake=~/.config/lua-language-server/3rd/luamake/luamake

if [ `tput cols` -gt "70" ]; then
function PRINT_CENTER {
  COLS=`tput cols`
  OFFSET=$(( ($COLS - $1) / 2 ))
  PRE=""
  for i in `seq $OFFSET`; do
    PRE="$PRE "
  done 
  while IFS= read -r line; do
    echo "$PRE$line"
  done <<< "$2"
}
PRINT_CENTER 60 "

       ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
       █░▄▄▀█▀▄▄▀█░▄▄░█▄░▄█▀▄▀██░▄░██░██░█░▄▄█░▄▄░█
       █░▀▀▄█░██░█░▀▄░██░██░█▀█░▀▀░▀█░██░█▄▄▀███▄██
       █▄█▄▄██▄▄██░▀▀░██▄███▄█████░███▄▄▄█▄▄▄█░▀▀░█
       ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
             
               ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          
                ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       
                      ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     
                       ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    
                      ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   
               ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  
              ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   
             ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  
             ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ 
                  ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     
                   ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     
▄▄▄ . ▌ ▐·▪  ▄▄▌    ▄▄▌ ▐ ▄▌▪  ▄▄▄▄▄ ▄ .▄      ▄• ▄▌▄▄▄▄▄
▀▄.▀·▪█·█▌██ ██•    ██· █▌▐███ •██  ██▪▐█ ▄█▀▄ █▪██▌•██  
▐▀▀▪▄▐█▐█•▐█·██ ▪   ██▪▐█▐▐▌▐█· ▐█.▪██▀▀█▐█▌.▐▌█▌▐█▌ ▐█.▪
▐█▄▄▌ ███ ▐█▌▐█▌ ▄  ▐█▌██▐█▌▐█▌ ▐█▌·██▌▐▀▐█▌.▐▌▐█▄█▌ ▐█▌·
 ▀▀▀ . ▀  ▀▀▀.▀▀▀    ▀▀▀▀ ▀▪▀▀▀ ▀▀▀ ▀▀▀ · ▀█▄▀▪ ▀▀▀  ▀▀▀ 

  > welcome x_x
"
fi

which wrk > /dev/null && eval `wrk tools bash`

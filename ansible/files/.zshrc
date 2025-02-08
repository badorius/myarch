# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/darthv/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

#START oh-my-zsh custom entries
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
export ZSH=/usr/share/oh-my-zsh/
source $ZSH/oh-my-zsh.sh

plugins=(
  git
  colorize
)


ZSH_THEME="random"
ZSH_THEME_RANDOM_CANDIDATES=(
  "nebirhos"
  "sonicradish"
  "agnoster"
  "jonathan"
)

ZSH_COLORIZE_STYLE="colorful"

source $ZSH/oh-my-zsh.sh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

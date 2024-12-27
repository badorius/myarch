# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/darthv/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

powerline-daemon -q
. /usr/share/powerline/bindings/zsh/powerline.zsh

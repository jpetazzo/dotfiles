#!/bin/sh
# Add custom promt to bashrc
cat ps1 >> ~/.bashrc

# Install other dotfiles
cp vimrc ~/.vimrc

# Move to home dir (to clone all repos there)
cd ~

# Install stern to view logs
[ -x /usr/local/bin/stern ] ||
  sudo wget -O /usr/local/bin/stern \
    https://github.com/wercker/stern/releases/download/1.10.0/stern_linux_amd64
[ -f /etc/bash_completion.d/stern ] ||
  stern --completion bash | sudo tee /etc/bash_completion.d/stern

# Install kubectx because it's awesome
[ -d kubectx ] ||
  git clone https://github.com/ahmetb/kubectx
[ -f /usr/local/bin/kctx ] ||
  sudo ln -s ~/kubectx/kubectx /usr/local/bin/kctx
[ -f /usr/local/bin/kns ] ||
  sudo ln -s ~/kubectx/kubens /usr/local/bin/kns
[ -f /etc/bash_completion.d/kubectx.bash ] ||
  sudo ln -s ~/kubectx/completion/kubectx.bash /etc/bash_completion.d/kubectx.bash
[ -f /etc/bash_completion.d/kubens ] ||
  sudo ln -s ~/kubectx/completion/kubens /etc/bash_completion.d/kubens.bash

# Install kube-ps1 because why not
[ -d kube-ps1 ] ||
  git clone https://github.com/jonmosco/kube-ps1

# Install completion for kubectl
[ -f /etc/bash_completion.d/kubectl ] ||
  kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl


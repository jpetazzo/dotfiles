#!/bin/sh
# Add custom promt to bashrc
cat ps1 >> ~/.bashrc

# Install other dotfiles
cp vimrc ~/.vimrc

check_for () {
  command -v $1 >/dev/null
}

# Move to home dir (to clone all repos there)
cd ~

# Install stern to view logs
check_for stern || {
  sudo wget -O /usr/local/bin/stern \
    https://github.com/wercker/stern/releases/download/1.10.0/stern_linux_amd64
  chmod +x /usr/local/bin/stern
}

[ -f /etc/bash_completion.d/stern ] ||
  stern --completion bash | sudo tee /etc/bash_completion.d/stern

# Install kubectx because it's awesome
[ -d kubectx ] ||
  git clone https://github.com/ahmetb/kubectx
check_for kctx ||
  sudo ln -s ~/kubectx/kubectx /usr/local/bin/kctx
check_for kns ||
  sudo ln -s ~/kubectx/kubens /usr/local/bin/kns
[ -f /etc/bash_completion.d/kubectx.bash ] ||
  sudo ln -s ~/kubectx/completion/kubectx.bash /etc/bash_completion.d/kubectx.bash
[ -f /etc/bash_completion.d/kubens.bash ] ||
  sudo ln -s ~/kubectx/completion/kubens /etc/bash_completion.d/kubens.bash

# Install kube-ps1 because why not
[ -d kube-ps1 ] || {
  git clone https://github.com/jonmosco/kube-ps1
  echo '. ~/kube-ps1/kube-ps1.sh' >> ~/.bashrc
}

# Install completion for kubectl
[ -f /etc/bash_completion.d/kubectl ] ||
  kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl


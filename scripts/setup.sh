#!/bin/bash

# ================================================
# Script de Automação para Instalação no Arch Linux
# ================================================

# Definindo o diretório de trabalho (opcional)
WORKDIR=~/setup

# Criar diretório para armazenar arquivos temporários
mkdir -p $WORKDIR
cd $WORKDIR

# Exibe uma mensagem de boas-vindas
echo "Iniciando a configuração automática do Arch Linux..."

# ================================================
# Atualizar o sistema
# ================================================
echo "Atualizando o sistema..."
sudo pacman -Syu --noconfirm

# ================================================
# Instalar Pacotes Essenciais
# ================================================
echo "Instalando pacotes essenciais..."
sudo pacman -S --noconfirm \
  base-devel \
  git \
  vim \
  zsh \
  curl \
  htop \
  neofetch \
  kitty \
  xorg-server \
  xorg-apps \
  bspwm \
  thunar \
  tlp \
  sxhkd \
  lightdm lightdm-gtk-greeter

# ================================================
# Configurar o TLP
# ================================================
echo "Ativando o TLP..."
sudo systemctl enable tlp
sudo systemctl start tlp

echo "Substituindo o arquivo de configuração do TLP..."
sudo cp ~/dotfiles/tlp/tlp /etc/default/tlp
# ================================================
# Instalar o Oh My Zsh
# ================================================
echo "Instalando Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Definir o Zsh como shell padrão
chsh -s $(which zsh)

# ================================================
# Clonando o Repositório de Dotfiles
# ================================================
echo "Clonando os dotfiles..."
git clone https://github.com/SEU_USUARIO/dotfiles.git $HOME/dotfiles

# ================================================
# Criando Links Simbólicos para os Dotfiles
# ================================================
echo "Criando links simbólicos para os dotfiles..."
ln -s $HOME/dotfiles/config $HOME/.config
ln -s $HOME/dotfiles/zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/oh-my-zsh $HOME/.zshrc
ln -s $HOME/dotfiles/git $HOME/.gitconfig

# ================================================
# Instalar o LightDM (Login Manager)
# ================================================
echo "Configurando o LightDM como gerenciador de login..."
sudo systemctl enable lightdm
sudo systemctl start lightdm

# ================================================
# Instalar o navegador Firefox
# ================================================
echo "Instalando o Firefox..."
sudo pacman -S --noconfirm firefox

# ================================================
# Instalar o editor de texto Visual Studio Code
# ================================================
echo "Instalando o Visual Studio Code..."
yay -S --noconfirm visual-studio-code-bin

# ================================================
# Instalar outros pacotes adicionais (opcional)
# ================================================
echo "Instalando pacotes adicionais..."
sudo pacman -S --noconfirm \
  vlc \
  gimp \
  kitty \
  flameshot \
  i3lock \
  feh \
  firefox \
  picom \
  pavucontrol \
  rofi \
  zoxide \
  fzf \
  audacity \
  skypeforlinux

# ================================================
# Finalizando
# ================================================
echo "Configuração concluída! Por favor, reinicie o sistema."


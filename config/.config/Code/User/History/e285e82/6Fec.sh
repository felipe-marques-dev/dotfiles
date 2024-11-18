#!/bin/bash

# ================================================
# Script de Automação para Instalação no Arch Linux
# ================================================

# Exibe uma mensagem de boas-vindas
echo "Iniciando a configuração automática do Arch Linux..."

# Atualizar o sistema
echo "Atualizando o sistema..."
sudo pacman -Syu --noconfirm

#Instalar o Yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Instalar Pacotes Essenciais
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

# Configurar o TLP
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
  tumbler \
  pfetch \
  fastfetch \
  xrandr \
  brightnessctl \
  zoxide \
  fzf \
  audacity \
  skypeforlinux \
  bluez \
  bluez-utils \
  blueberry 

# Clonando o Repositório de Dotfiles
echo "Clonando os dotfiles..."
git clone https://github.com/SEU_USUARIO/dotfiles.git $HOME/dotfiles

# Configuração do dotfiles
echo "Criando links simbólicos para os dotfiles..."

# Apagando pastas conflitantes
rm -rf ~/.config 
rm -rf ~/.zshrc
rm -rf ~/.oh-my-zsh
rm -rf .gitconfig

# Criando Links Simbólicos para os Dotfiles
ln -s $HOME/dotfiles/config $HOME/.config
ln -s $HOME/dotfiles/zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/oh-my-zsh $HOME/.oh-my-zsh
ln -s $HOME/dotfiles/git $HOME/.gitconfig




# ================================================
# Finalizando
# ================================================
echo "Configuração concluída! Por favor, reinicie o sistema."


#!.bin/bash
#!/bin/bash

# Asegurarse de tener privilegios de administrador
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como root o usa sudo."
  exit 1
fi

# Instalar Zsh y otras dependencias necesarias
echo "Instalando Zsh y dependencias..."
dnf install -y zsh git curl util-linux-user fonts-powerline

# Cambiar shell por defecto a Zsh
echo "Cambiando el shell por defecto a Zsh para el usuario actual..."
chsh -s $(which zsh)

# Instalar Oh My Zsh
echo "Instalando Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instalar el tema Powerlevel10k
echo "Clonando el tema Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Configurar Powerlevel10k como el tema predeterminado en .zshrc
echo "Configurando Powerlevel10k como tema predeterminado..."
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' $HOME/.zshrc

# Instalar plugins recomendados
echo "Instalando plugins de Zsh..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Activar plugins en .zshrc
echo "Activando plugins en .zshrc..."
sed -i 's/^plugins=(\(.*\))/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' $HOME/.zshrc

# Recargar Zsh
echo "Recargando Zsh..."
source $HOME/.zshrc

# Finalización
echo "Instalación completa. Reinicia tu terminal o ejecuta 'zsh' para aplicar los cambios."


#!/bin/bash

# Limpa o cache de cores do pywal
rm -rf .cache/wal

# Caminho para a pasta onde estão os wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"  # Altere para a pasta que deseja

# Arquivo onde vamos armazenar os wallpapers já usados
HISTORY_FILE="$HOME/.wallpaper_history"

# Verifica se o arquivo de histórico existe, se não, cria um
if [[ ! -f "$HISTORY_FILE" ]]; then
  touch "$HISTORY_FILE"
fi

# Obtém todos os wallpapers da pasta
ALL_WALLPAPERS=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \)))

# Remove os wallpapers que já foram usados (presentes no histórico)
AVAILABLE_WALLPAPERS=()
for wallpaper in "${ALL_WALLPAPERS[@]}"; do
  if ! grep -q "$wallpaper" "$HISTORY_FILE"; then
    AVAILABLE_WALLPAPERS+=("$wallpaper")
  fi
done

# Se não houver wallpapers disponíveis, reinicia o histórico
if [[ ${#AVAILABLE_WALLPAPERS[@]} -eq 0 ]]; then
  > "$HISTORY_FILE"  # Limpa o histórico
  AVAILABLE_WALLPAPERS=("${ALL_WALLPAPERS[@]}")  # Recarrega todos os wallpapers
fi

# Escolhe um wallpaper aleatoriamente da lista disponível
RANDOM_WALLPAPER="${AVAILABLE_WALLPAPERS[$RANDOM % ${#AVAILABLE_WALLPAPERS[@]}]}"

# Define o wallpaper usando o feh
feh --bg-scale "$RANDOM_WALLPAPER"

# Exibe o wallpaper escolhido
echo "Wallpaper escolhido: $RANDOM_WALLPAPER"

# Adiciona o wallpaper ao histórico para não ser repetido
echo "$RANDOM_WALLPAPER" >> "$HISTORY_FILE"

# Caso use pywal, também podemos atualizar as cores
bash ~/.config/polybar/cuts/scripts/pywal.sh "$RANDOM_WALLPAPER"


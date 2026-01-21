#!/bin/zsh

echo "🔍 Verificando atualizações disponíveis..."

# 1. Verificar atualizações do Homebrew
echo "--- Homebrew ---"
brew update > /dev/null
OUTDATED_BREW=$(brew outdated)

if [ -z "$OUTDATED_BREW" ]; then
    echo "✅ Todos os pacotes do Homebrew estão atualizados."
else
    echo "📦 Pacotes do Brew para atualizar:"
    echo "$OUTDATED_BREW"
fi

echo ""

# 2. Verificar atualizações do Sistema (macOS)
echo "--- Sistema macOS ---"
# O comando softwareupdate -l é um pouco lento
SYS_UPDATES=$(softwareupdate -l 2>&1)

if [[ "$SYS_UPDATES" == *"No new software available"* ]]; then
    echo "✅ O macOS está atualizado."
    SYS_NEED_UPDATE=false
else
    echo "🖥️  Há atualizações de sistema disponíveis!"
    echo "$SYS_UPDATES" | grep -E "^\s+\*\s+"
    SYS_NEED_UPDATE=true
fi

echo ""

# 3. Interação com o usuário
if [ -z "$OUTDATED_BREW" ] && [ "$SYS_NEED_UPDATE" = false ]; then
    echo "✨ Nada para fazer. Tudo está atualizado!"
    exit 0
fi

read -q "REPLY?Deseja instalar todas as atualizações acima? (y/n): "
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Atualizando Brew
    if [ ! -z "$OUTDATED_BREW" ]; then
        echo "🚀 Atualizando pacotes do Homebrew..."
        brew upgrade && brew cleanup
    fi

    # Atualizando Sistema
    if [ "$SYS_NEED_UPDATE" = true ]; then
        echo "🍎 Atualizando o sistema (pode solicitar sua senha de admin)..."
        sudo softwareupdate -ia
    fi
    
    echo "✔️ Processo concluído com sucesso!"
else
    echo "🚫 Atualização cancelada pelo usuário."
fi

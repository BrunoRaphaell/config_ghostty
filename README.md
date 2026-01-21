# 🎨 Configurações do Terminal Ghostty

Este repositório contém minhas configurações personalizadas para o terminal [Ghostty](https://github.com/ghostty-org/ghostty), incluindo integração com [Atuin](https://github.com/atuinsh/atuin) para histórico de comandos e [Yazi](https://github.com/sxyazi/yazi) como gerenciador de arquivos.

## 📸 Preview

![ghostty](images/imagem_ghostty.png)

### Terminal Ghostty em Ação

O terminal configurado com tema Catppuccin Mocha, fonte JetBrains Mono Nerd Font e transparência/blur para um visual moderno.

### Atuin - Histórico de Comandos Inteligente

![Atuin](images/atuin.png)

O Atuin permite buscar e navegar pelo histórico de comandos de forma eficiente, com busca semântica e estatísticas de execução.

### Yazi - Gerenciador de Arquivos

![Yazi](images/yazi.png)

Yazi oferece uma experiência moderna de navegação de arquivos diretamente no terminal, com preview e navegação intuitiva.

### Terminal Suspenso (Cmd+Esc)

![Terminal Suspenso](images/terminal_suspenso.png)

Atalho global `Cmd+Esc` para abrir/fechar o terminal rapidamente de qualquer aplicação.

## 🚀 Instalação

### Pré-requisitos

- macOS (testado no macOS Sonoma/Ventura)
- Homebrew instalado
- Git instalado

### 1. Instalar o Ghostty

```bash
brew install --cask ghostty
```

### 2. Instalar Zsh e Oh My Zsh

#### Instalar Zsh

O Zsh geralmente já vem pré-instalado no macOS. Para verificar:

```bash
zsh --version
```

Se não estiver instalado ou quiser atualizar:

```bash
brew install zsh
```

#### Instalar Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 3. Instalar Powerlevel10k (Tema)

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Depois, adicione ao seu `~/.zshrc`:

```zsh
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
```

### 4. Instalar Plugins do Zsh

#### zsh-syntax-highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

#### zsh-autosuggestions

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

#### zsh-history-substring-search

```bash
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
```

#### Outros plugins

Os plugins `z`, `sudo`, `web-search` e `copypath` já vêm incluídos com o Oh My Zsh.

### 5. Configurar o .zshrc

Copie o conteúdo do arquivo `.zshrc` fornecido ou adicione as seguintes configurações:

```zsh
plugins=(
  z
  sudo
  zsh-syntax-highlighting
  web-search
  copypath
  zsh-autosuggestions
  zsh-history-substring-search
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Bind keyboard shortcuts for zsh-history-substring-search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
```

### 6. Instalar e Configurar o Atuin

#### Instalação

```bash
brew install atuin
```

Também pode ser instalado com o comando, conforme a [documentação do Atuin](https://docs.atuin.sh/cli/guide/installation/#__tabbed_1_2):
```bash
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
```


#### Configuração no .zshrc

Adicione ao final do seu `~/.zshrc`:

```zsh
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
```

#### Sincronização (Opcional)

Para sincronizar seu histórico entre dispositivos:

```bash
atuin register -u <seu-usuario>
atuin login -u <seu-usuario>
```

E para sincronizar seu histórico com o que já foi executado no terminal:

```bash
atuin import auto
```

### 7. Instalar e Configurar o Yazi

#### Instalação

**1. Update brew:**

```bash
brew update
```

**2. Instalar dependências:**
```bash
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font
```

**3. Instalar Yazi:**
```bash
brew install yazi
```

#### Função Personalizada no .zshrc

Adicione esta função ao seu `~/.zshrc` para permitir que o Yazi mude o diretório atual após fechar:

```zsh
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f "$tmp"
}
```

**Como funciona:**
- Cria um arquivo temporário para armazenar o diretório atual
- Abre o Yazi com o arquivo temporário como referência
- Quando você fecha o Yazi, ele salva o diretório selecionado no arquivo temporário
- A função lê esse arquivo e muda para o diretório selecionado
- Remove o arquivo temporário após o uso

**Uso:**
```bash
y          # Abre Yazi no diretório atual
y /path    # Abre Yazi em um diretório específico
```

### 8. Configurar o Ghostty

Copie o arquivo `config` para o diretório de configuração do Ghostty:

```bash
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
cp config "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
```

Ou clone este repositório e faça um symlink:

```bash
git clone <seu-repositorio> ~/.config/ghostty
ln -s ~/.config/ghostty/config "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
```

### 9. Instalar Fontes Nerd Fonts

O tema requer uma fonte Nerd Font. Instale a [JetBrains Mono Nerd Font](https://formulae.brew.sh/cask/font-jetbrains-mono-nerd-font):

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

## ⌨️ Atalhos de Teclado

### Atalhos Globais do Ghostty

| Atalho | Ação |
|--------|------|
| `Cmd + Esc` | Abre/fecha o terminal suspenso (quick terminal) |

### Atalhos do Terminal Ghostty

#### Divisão de Tela (Splits)

| Atalho | Ação |
|--------|------|
| `Super + D` | Cria um split vertical (direita) |
| `Super + Shift + D` | Cria um split horizontal (baixo) |
| `Super + Ctrl + H` | Move para o split à esquerda |
| `Super + Ctrl + L` | Move para o split à direita |
| `Super + Ctrl + K` | Move para o split acima |
| `Super + Ctrl + J` | Move para o split abaixo |

#### Gerenciamento de Abas

| Atalho | Ação |
|--------|------|
| `Super + T` | Cria uma nova aba |
| `Super + W` | Fecha a superfície atual (split/aba) |
| `Super + Alt + →` | Próxima aba |
| `Super + Alt + ←` | Aba anterior |

#### Utilidades

| Atalho | Ação |
|--------|------|
| `Super + R` | Recarrega a configuração |
| `Super + Ctrl + F` | Alterna tela cheia |

**Nota:** `Super` refere-se à tecla `Cmd` (⌘) no macOS.

### Atalhos do Zsh (Histórico)

| Atalho | Ação |
|--------|------|
| `↑` (Seta para cima) | Busca no histórico (substring search) |
| `↓` (Seta para baixo) | Busca reversa no histórico |

### Atalhos do Atuin

| Atalho | Ação |
|--------|------|
| `Ctrl + R` | Abre o Atuin para busca no histórico |
| `Esc` | Fecha o Atuin |
| `Tab` | Edita o comando selecionado |
| `Enter` | Executa o comando selecionado |
| `Ctrl + O` | Inspeciona o histórico |

## 🛠️ Script de Atualização do macOS

O repositório inclui um script útil para atualizar o sistema e pacotes do Homebrew.

### Instalação do Script

1. Certifique-se de que o script está executável:

```bash
chmod +x /Users/balvesdematos/Documents/script/update_mac.sh
```

2. O alias já está configurado no `.zshrc`:

```zsh
alias update="/Users/balvesdematos/Documents/script/update_mac.sh"
```

### Uso

Simplesmente execute:

```bash
update
```

O script irá:
- Verificar atualizações do Homebrew
- Verificar atualizações do macOS
- Perguntar se deseja instalar as atualizações
- Executar as atualizações conforme sua escolha

## 🎨 Personalização

### Tema

O tema atual é **Catppuccin Mocha**. Para alterar, edite a linha no arquivo `config`:

```ini
theme = Catppuccin Mocha
```

Outros temas disponíveis podem ser encontrados na [documentação do Ghostty](https://ghostty.org/docs/themes).

### Fonte

A fonte padrão é **JetBrains Mono Nerd Font**. Para alterar:

```ini
font-family = "Sua Fonte Nerd Font"
font-size = 25
```

### Transparência e Blur

Ajuste a opacidade e blur no arquivo `config`:

```ini
background-opacity = 0.8  # 0.0 (transparente) a 1.0 (opaco)
background-blur = 90       # Intensidade do blur
```

## 🔧 Troubleshooting

### O terminal não abre com Cmd+Esc

Certifique-se de que o Ghostty tem permissões de acessibilidade:
1. Vá em **Preferências do Sistema > Privacidade e Segurança > Acessibilidade**
2. Adicione o Ghostty à lista de aplicativos permitidos

### Atuin não está funcionando

Verifique se o Atuin está instalado e inicializado:

```bash
atuin --version
atuin info
```

Se necessário, reinicialize o shell:

```bash
exec zsh
```

### Yazi não muda o diretório

Certifique-se de que a função `y()` está no seu `.zshrc` e que você está usando `y` e não `yazi` diretamente.

### Plugins do Zsh não funcionam

Verifique se os plugins estão instalados nos diretórios corretos:

```bash
ls ~/.oh-my-zsh/custom/plugins/
```

E certifique-se de que estão listados no array `plugins` do `.zshrc`.

## 📚 Recursos Adicionais

- [Documentação do Ghostty](https://ghostty.org/docs)
- [Documentação do Atuin](https://docs.atuin.sh/cli/guide/import/)
- [Documentação do Yazi](https://yazi-rs.github.io/docs/installation)
- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

## 📝 Licença

Este repositório contém apenas configurações pessoais. Sinta-se livre para usar e adaptar conforme suas necessidades.

## 🤝 Contribuições

Sugestões e melhorias são bem-vindas! Sinta-se à vontade para abrir uma issue ou pull request.

# Getting Started com GitHub CLI

Este guia fornece uma introdução prática ao GitHub CLI (gh) com exemplos hands-on.

## 📋 Pré-requisitos

### Instalação do GitHub CLI

#### Ubuntu/Debian
```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
```

#### macOS
```bash
brew install gh
```

#### Windows
```bash
winget install --id GitHub.cli
```

## 🔐 Autenticação

### Primeira Configuração
```bash
# Autenticar com GitHub
gh auth login

# Verificar status da autenticação
gh auth status

# Ver token atual
gh auth token
```

### Configuração de Git
```bash
# Configurar gh para usar HTTPS
gh auth setup-git

# Verificar configuração
git config --get credential.helper
```

## 🏗️ Operações Básicas com Repositórios

### Criar Repositório
```bash
# Criar repositório público
gh repo create meu-projeto --public --description "Descrição do projeto"

# Criar repositório privado
gh repo create meu-projeto-privado --private

# Criar e clonar automaticamente
gh repo create meu-projeto --public --clone
```

### Listar Repositórios
```bash
# Listar seus repositórios
gh repo list

# Listar com limite
gh repo list --limit 10

# Filtrar por linguagem
gh repo list --language python

# Repositórios de uma organização
gh repo list microsoft --limit 5
```

### Clonar Repositórios
```bash
# Clonar repositório
gh repo clone owner/repo

# Clonar e navegar
gh repo clone owner/repo && cd repo
```

### Informações do Repositório
```bash
# Ver informações do repositório atual
gh repo view

# Ver repositório específico
gh repo view microsoft/vscode

# Ver no browser
gh repo view --web
```

## 📝 Gerenciamento de Issues

### Criar Issues
```bash
# Criar issue interativamente
gh issue create

# Criar issue com parâmetros
gh issue create --title "Bug no login" --body "Descrição detalhada do bug"

# Criar issue com template
gh issue create --template bug_report.md
```

### Listar Issues
```bash
# Listar issues abertas
gh issue list

# Filtrar por estado
gh issue list --state closed

# Filtrar por assignee
gh issue list --assignee @me

# Filtrar por labels
gh issue list --label bug
```

### Gerenciar Issues
```bash
# Ver detalhes de uma issue
gh issue view 123

# Fechar issue
gh issue close 123

# Reabrir issue
gh issue reopen 123

# Comentar em issue
gh issue comment 123 --body "Comentário na issue"
```

## 🔄 Pull Requests

### Criar Pull Request
```bash
# Criar PR interativamente
gh pr create

# Criar PR com parâmetros
gh pr create --title "Feature: nova funcionalidade" --body "Descrição da mudança"

# Criar draft PR
gh pr create --draft
```

### Listar Pull Requests
```bash
# Listar PRs abertas
gh pr list

# Filtrar por estado
gh pr list --state merged

# Filtrar por autor
gh pr list --author @me
```

### Gerenciar Pull Requests
```bash
# Ver detalhes do PR
gh pr view 456

# Fazer checkout do PR
gh pr checkout 456

# Fazer merge do PR
gh pr merge 456

# Fechar PR sem merge
gh pr close 456

# Aprovar PR
gh pr review 456 --approve

# Solicitar mudanças
gh pr review 456 --request-changes --body "Precisa de ajustes"
```

## 🚀 GitHub Actions

### Listar Workflows
```bash
# Listar workflows
gh workflow list

# Ver runs de um workflow
gh run list --workflow=ci.yml

# Ver detalhes de um run
gh run view 123456789
```

### Executar Workflows
```bash
# Disparar workflow manualmente
gh workflow run ci.yml

# Disparar com inputs
gh workflow run deploy.yml --field environment=production
```

## 🔧 API do GitHub

### Chamadas Diretas à API
```bash
# GET request
gh api /user

# GET com parâmetros
gh api /repos/owner/repo/issues --field state=open

# POST request
gh api /repos/owner/repo/issues --method POST --field title="Nova issue" --field body="Descrição"

# Paginar resultados
gh api --paginate /user/repos
```

## 📦 Releases

### Criar Release
```bash
# Criar release
gh release create v1.0.0 --title "Versão 1.0.0" --notes "Primeira versão estável"

# Criar release com arquivos
gh release create v1.0.0 --title "Versão 1.0.0" --notes "Release notes" ./dist/*

# Criar pre-release
gh release create v1.0.0-beta --prerelease
```

### Gerenciar Releases
```bash
# Listar releases
gh release list

# Ver detalhes de release
gh release view v1.0.0

# Baixar assets de release
gh release download v1.0.0

# Deletar release
gh release delete v1.0.0
```

## 🎯 Próximos Passos

1. Explore os [exemplos práticos](../examples/) deste repositório
2. Execute os [scripts de teste](../scripts/) para validar sua configuração
3. Consulte a [referência completa de comandos](commands-reference.md)
4. Veja as [melhores práticas](best-practices.md) para uso avançado

## 🔗 Recursos Úteis

- [Documentação oficial do GitHub CLI](https://cli.github.com/manual/)
- [GitHub CLI no GitHub](https://github.com/cli/cli)
- [Exemplos da comunidade](https://github.com/topics/github-cli)


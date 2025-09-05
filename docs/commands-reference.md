# Referência Completa de Comandos GitHub CLI

Esta é uma referência abrangente dos comandos do GitHub CLI organizados por categoria.

## 🔐 Autenticação (`gh auth`)

### Comandos Básicos
```bash
# Login interativo
gh auth login

# Login com token
gh auth login --with-token < token.txt

# Verificar status
gh auth status

# Logout
gh auth logout

# Refresh token
gh auth refresh

# Setup Git credentials
gh auth setup-git
```

### Exemplos Práticos
```bash
# Login com escopo específico
gh auth login --scopes "repo,read:org"

# Login para GitHub Enterprise
gh auth login --hostname github.company.com

# Ver token atual
gh auth token
```

## 📁 Repositórios (`gh repo`)

### Criação e Clonagem
```bash
# Criar repositório público
gh repo create nome-repo --public

# Criar repositório privado
gh repo create nome-repo --private

# Criar com descrição
gh repo create nome-repo --description "Descrição do projeto"

# Criar e clonar
gh repo create nome-repo --public --clone

# Clonar repositório
gh repo clone owner/repo

# Fork repositório
gh repo fork owner/repo
```

### Gerenciamento
```bash
# Ver informações
gh repo view
gh repo view owner/repo

# Listar repositórios
gh repo list
gh repo list owner --limit 10

# Editar repositório
gh repo edit --description "Nova descrição"
gh repo edit --visibility private

# Deletar repositório
gh repo delete owner/repo

# Arquivar repositório
gh repo archive owner/repo
```

### Sincronização
```bash
# Sync fork
gh repo sync owner/repo

# Set default branch
gh repo edit --default-branch main
```

## 🐛 Issues (`gh issue`)

### Criação
```bash
# Criar issue interativamente
gh issue create

# Criar com parâmetros
gh issue create --title "Título" --body "Descrição"

# Criar com template
gh issue create --template bug_report.md

# Criar com labels e assignees
gh issue create --title "Bug" --label bug --assignee @me
```

### Listagem e Busca
```bash
# Listar issues abertas
gh issue list

# Filtrar por estado
gh issue list --state closed
gh issue list --state all

# Filtrar por autor
gh issue list --author username

# Filtrar por assignee
gh issue list --assignee @me

# Filtrar por labels
gh issue list --label bug,enhancement

# Buscar issues
gh issue list --search "error in login"
```

### Gerenciamento
```bash
# Ver detalhes
gh issue view 123

# Comentar
gh issue comment 123 --body "Comentário"

# Fechar issue
gh issue close 123

# Reabrir issue
gh issue reopen 123

# Editar issue
gh issue edit 123 --title "Novo título"

# Adicionar labels
gh issue edit 123 --add-label bug,priority-high

# Remover labels
gh issue edit 123 --remove-label wontfix

# Atribuir issue
gh issue edit 123 --add-assignee username

# Pin issue
gh issue pin 123

# Transfer issue
gh issue transfer 123 owner/other-repo
```

## 🔄 Pull Requests (`gh pr`)

### Criação
```bash
# Criar PR interativamente
gh pr create

# Criar com parâmetros
gh pr create --title "Feature" --body "Descrição"

# Criar draft PR
gh pr create --draft

# Criar com reviewers
gh pr create --reviewer username1,username2

# Criar com base branch
gh pr create --base develop
```

### Listagem e Busca
```bash
# Listar PRs abertas
gh pr list

# Filtrar por estado
gh pr list --state merged
gh pr list --state closed

# Filtrar por autor
gh pr list --author @me

# Filtrar por reviewer
gh pr list --search "review:username"

# Filtrar por base branch
gh pr list --base main
```

### Gerenciamento
```bash
# Ver detalhes
gh pr view 456

# Checkout PR
gh pr checkout 456

# Merge PR
gh pr merge 456
gh pr merge 456 --squash
gh pr merge 456 --rebase

# Fechar PR
gh pr close 456

# Reabrir PR
gh pr reopen 456

# Marcar como ready
gh pr ready 456

# Converter para draft
gh pr ready 456 --undo
```

### Review
```bash
# Aprovar PR
gh pr review 456 --approve

# Solicitar mudanças
gh pr review 456 --request-changes --body "Precisa de ajustes"

# Comentar
gh pr review 456 --comment --body "Looks good!"

# Ver reviews
gh pr view 456 --json reviews
```

## 🚀 GitHub Actions

### Workflows (`gh workflow`)
```bash
# Listar workflows
gh workflow list

# Ver workflow
gh workflow view workflow.yml

# Executar workflow
gh workflow run workflow.yml

# Executar com inputs
gh workflow run deploy.yml --field environment=production

# Habilitar/desabilitar workflow
gh workflow enable workflow.yml
gh workflow disable workflow.yml
```

### Runs (`gh run`)
```bash
# Listar runs
gh run list

# Filtrar por workflow
gh run list --workflow=ci.yml

# Filtrar por status
gh run list --status=failure

# Ver detalhes do run
gh run view 123456789

# Ver logs
gh run view 123456789 --log

# Baixar artifacts
gh run download 123456789

# Cancelar run
gh run cancel 123456789

# Rerun workflow
gh run rerun 123456789

# Watch run
gh run watch 123456789
```

### Cache (`gh cache`)
```bash
# Listar caches
gh cache list

# Deletar cache
gh cache delete cache-key

# Deletar todos os caches
gh cache delete --all
```

## 📦 Releases (`gh release`)

### Criação
```bash
# Criar release
gh release create v1.0.0

# Criar com título e notas
gh release create v1.0.0 --title "Version 1.0.0" --notes "Release notes"

# Criar com arquivos
gh release create v1.0.0 --title "v1.0.0" --notes "Notes" ./dist/*

# Criar pre-release
gh release create v1.0.0-beta --prerelease

# Criar draft
gh release create v1.0.0 --draft
```

### Gerenciamento
```bash
# Listar releases
gh release list

# Ver release
gh release view v1.0.0

# Editar release
gh release edit v1.0.0 --notes "Updated notes"

# Baixar assets
gh release download v1.0.0

# Baixar asset específico
gh release download v1.0.0 --pattern "*.zip"

# Upload assets
gh release upload v1.0.0 ./file.zip

# Deletar release
gh release delete v1.0.0

# Deletar asset
gh release delete-asset v1.0.0 file.zip
```

## 🌐 API (`gh api`)

### Chamadas Básicas
```bash
# GET request
gh api /user

# GET com parâmetros
gh api /repos/owner/repo/issues --field state=open

# POST request
gh api /repos/owner/repo/issues --method POST --field title="Issue" --field body="Body"

# PUT request
gh api /repos/owner/repo --method PUT --field description="New description"

# DELETE request
gh api /repos/owner/repo/issues/123 --method DELETE
```

### Paginação e Filtros
```bash
# Paginar resultados
gh api --paginate /user/repos

# Filtrar com jq
gh api /user --jq '.login'

# Headers customizados
gh api /user --header "Accept: application/vnd.github.v3+json"

# Raw output
gh api /user --jq -r '.login'
```

## 📝 Gists (`gh gist`)

### Criação
```bash
# Criar gist de arquivo
gh gist create file.txt

# Criar gist público
gh gist create --public file.txt

# Criar com descrição
gh gist create --desc "Description" file.txt

# Criar de stdin
echo "content" | gh gist create --filename "file.txt"
```

### Gerenciamento
```bash
# Listar gists
gh gist list

# Ver gist
gh gist view gist-id

# Editar gist
gh gist edit gist-id

# Clonar gist
gh gist clone gist-id

# Deletar gist
gh gist delete gist-id
```

## 🏢 Organizações (`gh org`)

```bash
# Listar organizações
gh api user/orgs

# Ver organização
gh api orgs/org-name

# Listar membros
gh api orgs/org-name/members

# Listar repositórios da org
gh repo list org-name
```

## 🔧 Configuração e Extensões

### Aliases
```bash
# Criar alias
gh alias set co "pr checkout"

# Listar aliases
gh alias list

# Deletar alias
gh alias delete co
```

### Extensões
```bash
# Listar extensões
gh extension list

# Instalar extensão
gh extension install owner/gh-extension

# Atualizar extensões
gh extension upgrade --all

# Remover extensão
gh extension remove owner/gh-extension
```

### Configuração
```bash
# Ver configuração
gh config list

# Definir configuração
gh config set editor vim

# Ver configuração específica
gh config get editor
```

## 🎯 Dicas Avançadas

### Combinando Comandos
```bash
# Criar issue e PR em sequência
gh issue create --title "Bug fix" --body "Description" && \
git checkout -b fix-bug && \
# fazer mudanças
git add . && git commit -m "Fix bug" && \
git push -u origin fix-bug && \
gh pr create --title "Fix bug" --body "Fixes issue"

# Listar PRs e fazer checkout do primeiro
gh pr list --json number --jq '.[0].number' | xargs gh pr checkout
```

### Templates e Automação
```bash
# Usar template de issue
gh issue create --template .github/ISSUE_TEMPLATE/bug_report.md

# Criar PR com template
gh pr create --template .github/pull_request_template.md

# Executar workflow com matriz
gh workflow run test.yml --field os=ubuntu-latest --field node-version=18
```

### Formatação de Output
```bash
# JSON output
gh repo view --json name,description,stargazerCount

# Template output
gh issue list --template '{{range .}}{{.number}}: {{.title}}{{"\n"}}{{end}}'

# CSV output
gh repo list --json name,stargazerCount --template '{{range .}}{{.name}},{{.stargazerCount}}{{"\n"}}{{end}}'
```


#!/bin/bash

# GitHub CLI Demo Script
# Este script demonstra as principais funcionalidades do GitHub CLI

set -e

echo "🚀 GitHub CLI Demo Script"
echo "========================="
echo

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para imprimir seções
print_section() {
    echo -e "${BLUE}📋 $1${NC}"
    echo "----------------------------------------"
}

# Função para imprimir comandos
print_command() {
    echo -e "${YELLOW}$ $1${NC}"
}

# Função para imprimir sucesso
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    echo
}

# Verificar se gh está instalado e autenticado
print_section "Verificação de Pré-requisitos"
print_command "gh --version"
gh --version

print_command "gh auth status"
if gh auth status > /dev/null 2>&1; then
    print_success "GitHub CLI está autenticado"
else
    echo -e "${RED}❌ GitHub CLI não está autenticado. Execute: gh auth login${NC}"
    exit 1
fi

# Informações do usuário
print_section "Informações do Usuário"
print_command "gh api user --jq '.login, .name, .public_repos'"
USER_INFO=$(gh api user --jq '{login: .login, name: .name, repos: .public_repos}')
echo "$USER_INFO"
print_success "Informações do usuário obtidas"

# Listar repositórios
print_section "Repositórios do Usuário"
print_command "gh repo list --limit 5"
gh repo list --limit 5
print_success "Lista de repositórios obtida"

# Informações do repositório atual
print_section "Repositório Atual"
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    print_command "gh repo view"
    gh repo view --json name,description,url,stargazerCount,forkCount | jq '.'
    print_success "Informações do repositório atual obtidas"
else
    echo "⚠️  Não está em um repositório Git"
fi

# Criar uma issue de exemplo
print_section "Criando Issue de Exemplo"
ISSUE_TITLE="Demo: Teste automatizado $(date '+%Y-%m-%d %H:%M:%S')"
ISSUE_BODY="Esta é uma issue criada automaticamente pelo script de demonstração do GitHub CLI.

## Detalhes
- Data: $(date)
- Script: demo-script.sh
- Propósito: Demonstração das capacidades do GitHub CLI

Esta issue pode ser fechada após a demonstração."

print_command "gh issue create --title \"$ISSUE_TITLE\" --body \"...\""
ISSUE_NUMBER=$(gh issue create --title "$ISSUE_TITLE" --body "$ISSUE_BODY" --json number --jq '.number')
print_success "Issue #$ISSUE_NUMBER criada"

# Listar issues
print_section "Listando Issues"
print_command "gh issue list --limit 3"
gh issue list --limit 3
print_success "Lista de issues obtida"

# Comentar na issue criada
print_section "Comentando na Issue"
COMMENT_BODY="Comentário automático adicionado pelo script de demonstração. 🤖"
print_command "gh issue comment $ISSUE_NUMBER --body \"$COMMENT_BODY\""
gh issue comment $ISSUE_NUMBER --body "$COMMENT_BODY"
print_success "Comentário adicionado à issue #$ISSUE_NUMBER"

# Fechar a issue
print_section "Fechando Issue de Demonstração"
print_command "gh issue close $ISSUE_NUMBER"
gh issue close $ISSUE_NUMBER
print_success "Issue #$ISSUE_NUMBER fechada"

# Verificar workflows (se existirem)
print_section "GitHub Actions"
print_command "gh workflow list"
if gh workflow list --json name | jq -e '. | length > 0' > /dev/null; then
    gh workflow list
    print_success "Workflows listados"
else
    echo "ℹ️  Nenhum workflow encontrado"
fi

# Verificar releases (se existirem)
print_section "Releases"
print_command "gh release list --limit 3"
if gh release list --limit 3 | grep -q .; then
    gh release list --limit 3
    print_success "Releases listados"
else
    echo "ℹ️  Nenhuma release encontrada"
fi

# Estatísticas finais
print_section "Estatísticas do Repositório"
print_command "gh api repos/:owner/:repo --jq '{stars: .stargazers_count, forks: .forks_count, issues: .open_issues_count}'"
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    gh api repos/:owner/:repo --jq '{stars: .stargazers_count, forks: .forks_count, issues: .open_issues_count}'
    print_success "Estatísticas obtidas"
fi

echo
echo -e "${GREEN}🎉 Demonstração concluída com sucesso!${NC}"
echo -e "${BLUE}📚 Para mais exemplos, consulte a documentação em docs/getting-started.md${NC}"
echo


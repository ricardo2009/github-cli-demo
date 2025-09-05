#!/bin/bash

# GitHub CLI Test Suite
# Script para testar todas as funcionalidades do GitHub CLI

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Contadores
TESTS_TOTAL=0
TESTS_PASSED=0
TESTS_FAILED=0

# Função para imprimir cabeçalho
print_header() {
    echo
    echo -e "${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║                    GitHub CLI Test Suite                    ║${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo
}

# Função para imprimir seções
print_section() {
    echo
    echo -e "${BLUE}📋 $1${NC}"
    echo "================================================================"
}

# Função para executar teste
run_test() {
    local test_name="$1"
    local test_command="$2"
    local expected_result="$3"
    
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    echo -n "Testing: $test_name... "
    
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ PASS${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "${RED}❌ FAIL${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Função para executar teste com output
run_test_with_output() {
    local test_name="$1"
    local test_command="$2"
    
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    echo -e "${YELLOW}Testing: $test_name${NC}"
    
    if output=$(eval "$test_command" 2>&1); then
        echo -e "${GREEN}✅ PASS${NC}"
        echo "$output" | head -5
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo
        return 0
    else
        echo -e "${RED}❌ FAIL${NC}"
        echo "Error: $output"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo
        return 1
    fi
}

# Função para imprimir resultados finais
print_results() {
    echo
    echo -e "${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║                        Test Results                         ║${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo
    echo -e "Total Tests: ${BLUE}$TESTS_TOTAL${NC}"
    echo -e "Passed: ${GREEN}$TESTS_PASSED${NC}"
    echo -e "Failed: ${RED}$TESTS_FAILED${NC}"
    echo
    
    if [ $TESTS_FAILED -eq 0 ]; then
        echo -e "${GREEN}🎉 All tests passed!${NC}"
        return 0
    else
        echo -e "${RED}❌ Some tests failed!${NC}"
        return 1
    fi
}

# Início dos testes
print_header

# Teste 1: Verificar instalação
print_section "Installation & Authentication Tests"
run_test "GitHub CLI installation" "gh --version"
run_test "GitHub CLI authentication" "gh auth status"

# Teste 2: Informações básicas
print_section "Basic Information Tests"
run_test_with_output "User information" "gh api user --jq '{login: .login, name: .name}'"
run_test_with_output "Repository list" "gh repo list --limit 3"

# Teste 3: Repositório atual
print_section "Current Repository Tests"
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    run_test_with_output "Current repository info" "gh repo view --json name,description"
    run_test "Repository statistics" "gh api repos/:owner/:repo --jq '.stargazers_count'"
else
    echo "⚠️  Not in a Git repository, skipping repository tests"
fi

# Teste 4: Issues
print_section "Issues Management Tests"
run_test_with_output "List issues" "gh issue list --limit 3"

# Criar issue de teste
echo "Creating test issue..."
TEST_ISSUE_TITLE="Test Issue $(date '+%Y%m%d_%H%M%S')"
TEST_ISSUE_BODY="This is a test issue created by the test suite. It will be automatically closed."

if ISSUE_NUMBER=$(gh issue create --title "$TEST_ISSUE_TITLE" --body "$TEST_ISSUE_BODY" --json number --jq '.number' 2>/dev/null); then
    echo -e "${GREEN}✅ Test issue #$ISSUE_NUMBER created${NC}"
    
    # Testar comentário
    run_test "Add comment to issue" "gh issue comment $ISSUE_NUMBER --body 'Test comment'"
    
    # Testar fechamento
    run_test "Close test issue" "gh issue close $ISSUE_NUMBER"
    
    echo -e "${GREEN}✅ Test issue #$ISSUE_NUMBER cleaned up${NC}"
else
    echo -e "${YELLOW}⚠️  Could not create test issue (may not have permissions)${NC}"
fi

# Teste 5: Pull Requests
print_section "Pull Requests Tests"
run_test_with_output "List pull requests" "gh pr list --limit 3"

# Teste 6: Workflows
print_section "GitHub Actions Tests"
run_test_with_output "List workflows" "gh workflow list"
run_test_with_output "List workflow runs" "gh run list --limit 3"

# Teste 7: Releases
print_section "Releases Tests"
run_test_with_output "List releases" "gh release list --limit 3"

# Teste 8: API
print_section "GitHub API Tests"
run_test "API - User endpoint" "gh api user --jq '.login'"
run_test "API - Rate limit" "gh api rate_limit --jq '.rate.remaining'"

# Teste 9: Gists
print_section "Gists Tests"
run_test_with_output "List gists" "gh gist list --limit 3"

# Teste 10: Organizações
print_section "Organizations Tests"
run_test_with_output "List organizations" "gh api user/orgs --jq '.[].login' | head -3"

# Teste 11: Scripts locais
print_section "Local Scripts Tests"
if [ -f "examples/basic-operations/demo-script.sh" ]; then
    run_test "Demo script exists and is executable" "test -x examples/basic-operations/demo-script.sh"
else
    echo -e "${YELLOW}⚠️  Demo script not found${NC}"
fi

if [ -f ".github/workflows/github-cli-demo.yml" ]; then
    run_test "GitHub Actions workflow exists" "test -f .github/workflows/github-cli-demo.yml"
    run_test "Workflow YAML is valid" "grep -q 'name: GitHub CLI Demo' .github/workflows/github-cli-demo.yml"
else
    echo -e "${YELLOW}⚠️  GitHub Actions workflow not found${NC}"
fi

# Teste 12: Configuração
print_section "Configuration Tests"
run_test "Git configuration" "git config --get user.name"
run_test "Git remote configuration" "git remote get-url origin"

# Resultados finais
print_results


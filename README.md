# GitHub CLI Demo Lab

Um laboratório prático para demonstrar e testar as capacidades do GitHub CLI (gh), inspirado na estrutura dos [Azure AKS Labs](https://azure-samples.github.io/aks-labs/).

## 🎯 Objetivo

Este repositório serve como um laboratório hands-on para:
- Demonstrar todas as funcionalidades do GitHub CLI
- Fornecer exemplos práticos de uso
- Testar automações e integrações
- Servir como referência para desenvolvedores

## 🚀 Quick Start

### Pré-requisitos
- GitHub CLI instalado (`gh --version`)
- Git configurado
- Conta GitHub autenticada (`gh auth status`)

### Instalação
```bash
git clone https://github.com/ricardo2009/github-cli-demo.git
cd github-cli-demo
```

## 📚 Estrutura do Laboratório

### 🔧 Funcionalidades Básicas
- [x] Autenticação e configuração
- [x] Gerenciamento de repositórios
- [ ] Issues e Pull Requests
- [ ] GitHub Actions
- [ ] Releases e Tags

### 🏗️ Estrutura do Projeto
```
github-cli-demo/
├── README.md                 # Documentação principal
├── docs/                     # Documentação detalhada
│   ├── getting-started.md    # Guia inicial
│   ├── commands-reference.md # Referência de comandos
│   └── best-practices.md     # Melhores práticas
├── examples/                 # Exemplos práticos
│   ├── basic-operations/     # Operações básicas
│   ├── automation/           # Scripts de automação
│   └── workflows/            # GitHub Actions
├── scripts/                  # Scripts utilitários
│   ├── setup.sh             # Script de configuração
│   └── test-all.sh          # Script de testes
└── tests/                    # Testes automatizados
    ├── unit/                 # Testes unitários
    └── integration/          # Testes de integração
```

## 🛠️ Capacidades do GitHub CLI

### Core Commands
- `gh auth` - Autenticação
- `gh repo` - Gerenciamento de repositórios
- `gh issue` - Gerenciamento de issues
- `gh pr` - Pull requests
- `gh release` - Releases
- `gh workflow` - GitHub Actions

### GitHub Actions Commands
- `gh run` - Workflow runs
- `gh workflow` - Workflows
- `gh cache` - Cache management

### Additional Commands
- `gh api` - API calls diretas
- `gh gist` - Gerenciamento de gists
- `gh codespace` - GitHub Codespaces
- `gh org` - Organizações

## 📖 Guias de Laboratório

1. **[Getting Started](docs/getting-started.md)** - Configuração inicial e primeiros passos
2. **[Repository Management](examples/basic-operations/)** - Criação e gerenciamento de repos
3. **[Issues & Pull Requests](examples/basic-operations/)** - Workflow de desenvolvimento
4. **[GitHub Actions Integration](examples/workflows/)** - Automação com Actions
5. **[API Integration](examples/automation/)** - Uso da API do GitHub
6. **[Advanced Automation](scripts/)** - Scripts avançados

## 🧪 Testes e Validação

Execute todos os testes:
```bash
./scripts/test-all.sh
```

Testes individuais:
```bash
# Testar autenticação
gh auth status

# Testar operações básicas
./tests/integration/basic-operations.sh

# Testar automações
./tests/integration/automation.sh
```

## 🤝 Contribuindo

1. Fork este repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🔗 Recursos Relacionados

- [GitHub CLI Documentation](https://cli.github.com/manual/)
- [GitHub CLI Quickstart](https://docs.github.com/en/github-cli/github-cli/quickstart)
- [GitHub API Documentation](https://docs.github.com/en/rest)
- [Azure AKS Labs](https://azure-samples.github.io/aks-labs/) - Inspiração para este projeto

## 📊 Status do Projeto

![GitHub last commit](https://img.shields.io/github/last-commit/ricardo2009/github-cli-demo)
![GitHub issues](https://img.shields.io/github/issues/ricardo2009/github-cli-demo)
![GitHub pull requests](https://img.shields.io/github/issues-pr/ricardo2009/github-cli-demo)

---

**Nota**: Este é um projeto de demonstração criado para fins educacionais e de teste das capacidades do GitHub CLI.


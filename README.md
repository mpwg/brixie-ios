# Brixie iOS

A modern iOS application built with SwiftUI and SwiftData.

## 🚀 Quick Start

### Prerequisites

- Xcode 15.0 or later
- iOS 17.0 or later
- macOS 13.0 or later (for development)

### Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/mpwg/brixie-ios.git
   cd brixie-ios
   ```

2. Set up development environment:
   ```bash
   make setup
   ```

3. Build and run:
   ```bash
   make build
   ```

## 🛠 Development

### Available Commands

Use the Makefile for common development tasks:

```bash
make help           # Show all available commands
make build          # Build the app
make test           # Run all tests
make lint           # Run SwiftLint
make format         # Format code with swift-format
make docs           # Generate documentation
make clean          # Clean build artifacts
```

### Code Quality

This project uses several tools to maintain code quality:

- **SwiftLint**: Enforces Swift style and conventions
- **swift-format**: Automatically formats Swift code
- **Pre-commit hooks**: Runs checks before each commit

Configuration files:
- `.swiftlint.yml` - SwiftLint rules
- `.swift-format` - Swift format configuration
- `.pre-commit-config.yaml` - Pre-commit hooks

### Testing

Run tests using:

```bash
make test           # All tests
make test-unit      # Unit tests only
make test-ui        # UI tests only
```

## 🏗 CI/CD Pipeline

### GitHub Actions Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| **iOS CI** | Push, PR | Build and test the app |
| **Code Quality** | Push, PR | SwiftLint, swift-format, static analysis |
| **Security Analysis** | Push, PR, Schedule | CodeQL, dependency scanning |
| **Release** | Tags, Manual | Build and create releases |
| **Documentation** | Push to main | Generate and deploy docs |
| **PR Validation** | Pull Requests | Comprehensive PR checks |

### Workflow Features

- ✅ **Automated building and testing**
- ✅ **Code quality checks** (SwiftLint, swift-format)
- ✅ **Security scanning** (CodeQL, Trivy)
- ✅ **Dependency updates** (Dependabot)
- ✅ **Release automation**
- ✅ **Documentation generation**
- ✅ **PR validation and labeling**

## 📋 Project Structure

```
brixie-ios/
├── .github/                    # GitHub configuration
│   ├── workflows/             # CI/CD workflows
│   │   ├── ios.yml           # Main iOS CI pipeline
│   │   ├── code-quality.yml  # Code quality checks
│   │   ├── codeql.yml        # Security analysis
│   │   ├── release.yml       # Release automation
│   │   ├── docs.yml          # Documentation
│   │   └── pr.yml            # PR validation
│   ├── ISSUE_TEMPLATE/       # Issue templates
│   ├── pull_request_template.md
│   ├── dependabot.yml        # Dependency updates
│   ├── auto-assign.yml       # Auto-assign reviewers
│   └── labeler.yml           # Auto-label PRs
├── Brixie/                    # Xcode project
│   ├── Brixie/               # Main app target
│   ├── BrixieTests/          # Unit tests
│   └── BrixieUITests/        # UI tests
├── docker/                    # Docker configuration
├── docs/                      # Documentation
├── .swiftlint.yml            # SwiftLint configuration
├── .swift-format             # Swift format configuration
├── .pre-commit-config.yaml   # Pre-commit hooks
├── .editorconfig             # Editor configuration
├── docker-compose.yml        # Development services
├── Makefile                  # Development commands
└── README.md                 # This file
```

## 🔧 Configuration Files

### YAML Configuration Files

| File | Purpose | Key Features |
|------|---------|-------------|
| `.github/workflows/ios.yml` | Main CI pipeline | Build, test, artifact upload |
| `.github/workflows/code-quality.yml` | Code quality | SwiftLint, swift-format, static analysis |
| `.github/workflows/codeql.yml` | Security analysis | CodeQL, dependency scanning |
| `.github/workflows/release.yml` | Release automation | Archive, IPA generation, GitHub releases |
| `.github/workflows/docs.yml` | Documentation | Swift-DocC, GitHub Pages deployment |
| `.github/workflows/pr.yml` | PR validation | Size checks, conflict detection, auto-labeling |
| `.github/dependabot.yml` | Dependency management | Swift packages, GitHub Actions updates |
| `.swiftlint.yml` | SwiftLint rules | Comprehensive Swift style enforcement |
| `.pre-commit-config.yaml` | Pre-commit hooks | Automated code quality checks |
| `docker-compose.yml` | Development services | Documentation, testing, quality tools |

### Development Tools Configuration

- **SwiftLint**: Enforces 80+ Swift style rules with custom configurations
- **swift-format**: Automated code formatting with consistent style
- **EditorConfig**: Consistent coding styles across different editors
- **Pre-commit**: Automated checks before commits
- **Dependabot**: Automated dependency updates with grouping and scheduling

## 🚦 Workflows in Detail

### iOS CI Workflow (`.github/workflows/ios.yml`)
- **Triggers**: Push to main/docs branches, PRs to main
- **Features**: 
  - Xcode setup and caching
  - Swift Package Manager caching
  - CocoaPods support
  - Unit and UI test execution
  - Build artifact upload
  - Test result reporting

### Code Quality Workflow (`.github/workflows/code-quality.yml`)
- **Triggers**: Push/PR to main/develop
- **Features**:
  - SwiftLint with GitHub Actions reporting
  - swift-format validation
  - Xcode static analysis
  - Quality report artifacts

### Security Analysis (`.github/workflows/codeql.yml`)
- **Triggers**: Push/PR, weekly schedule
- **Features**:
  - CodeQL analysis for Swift
  - Trivy vulnerability scanning
  - SARIF result upload to GitHub Security
  - Extended security queries

### Release Workflow (`.github/workflows/release.yml`)
- **Triggers**: Version tags, manual dispatch
- **Features**:
  - Archive creation
  - IPA export (with proper certificates)
  - Automated release notes
  - GitHub release creation
  - Build artifact upload

### Documentation Workflow (`.github/workflows/docs.yml`)
- **Triggers**: Push to main, documentation changes
- **Features**:
  - Swift-DocC documentation generation
  - GitHub Pages deployment
  - Markdown linting
  - Link validation

### PR Validation (`.github/workflows/pr.yml`)
- **Triggers**: PR events
- **Features**:
  - PR title validation (semantic)
  - Size labeling
  - Conflict detection
  - Danger checks
  - Auto-reviewer assignment
  - Automated labeling

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run quality checks: `make ci-all`
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

### PR Guidelines

- Use semantic commit messages
- Ensure all CI checks pass
- Add tests for new functionality
- Update documentation as needed
- Keep PRs focused and reasonably sized

## 📱 App Features

- **SwiftUI Interface**: Modern, declarative UI
- **SwiftData Integration**: Core Data successor for data persistence
- **Cross-platform**: iOS and macOS support (Catalyst)
- **Testing**: Comprehensive unit and UI test coverage

## 🛡 Security

This project implements several security measures:

- **CodeQL Analysis**: Automated security vulnerability detection
- **Dependency Scanning**: Regular security updates via Dependabot
- **Secret Detection**: Pre-commit hooks to prevent credential leaks
- **SARIF Integration**: Security findings integrated with GitHub Security tab

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with SwiftUI and SwiftData
- CI/CD powered by GitHub Actions
- Code quality enforced by SwiftLint and swift-format
- Documentation generated with Swift-DocC

---

For more information, check out the [documentation](https://mpwg.github.io/brixie-ios) or [open an issue](https://github.com/mpwg/brixie-ios/issues/new/choose).
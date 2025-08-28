# Makefile for Brixie iOS Development
# Provides common development and CI/CD tasks

.PHONY: help setup clean build test lint format docs docker-up docker-down

# Default target
help: ## Show this help message
	@echo "Brixie iOS Development Commands"
	@echo "==============================="
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Development setup
setup: ## Set up development environment
	@echo "🔧 Setting up development environment..."
	@if command -v brew >/dev/null 2>&1; then \
		echo "📦 Installing development tools..."; \
		brew install swiftlint swift-format; \
	else \
		echo "⚠️  Homebrew not found. Please install manually:"; \
		echo "   - SwiftLint: https://github.com/realm/SwiftLint"; \
		echo "   - swift-format: https://github.com/apple/swift-format"; \
	fi
	@echo "✅ Setup complete!"

# Build targets
build: ## Build the iOS app
	@echo "🏗️  Building Brixie..."
	@cd Brixie && xcodebuild -project Brixie.xcodeproj -scheme Brixie -destination "generic/platform=iOS Simulator" build

build-release: ## Build the iOS app for release
	@echo "🏗️  Building Brixie for release..."
	@cd Brixie && xcodebuild -project Brixie.xcodeproj -scheme Brixie -configuration Release -destination "generic/platform=iOS" build

# Testing
test: ## Run all tests
	@echo "🧪 Running tests..."
	@cd Brixie && xcodebuild test -project Brixie.xcodeproj -scheme Brixie -destination "platform=iOS Simulator,name=iPhone 15,OS=latest"

test-ui: ## Run UI tests only
	@echo "🧪 Running UI tests..."
	@cd Brixie && xcodebuild test -project Brixie.xcodeproj -scheme Brixie -destination "platform=iOS Simulator,name=iPhone 15,OS=latest" -only-testing:BrixieUITests

test-unit: ## Run unit tests only
	@echo "🧪 Running unit tests..."
	@cd Brixie && xcodebuild test -project Brixie.xcodeproj -scheme Brixie -destination "platform=iOS Simulator,name=iPhone 15,OS=latest" -only-testing:BrixieTests

# Code quality
lint: ## Run SwiftLint
	@echo "🔍 Running SwiftLint..."
	@if command -v swiftlint >/dev/null 2>&1; then \
		swiftlint lint; \
	else \
		echo "⚠️  SwiftLint not found. Run 'make setup' first."; \
	fi

lint-fix: ## Run SwiftLint with auto-fix
	@echo "🔧 Running SwiftLint with auto-fix..."
	@if command -v swiftlint >/dev/null 2>&1; then \
		swiftlint --fix; \
	else \
		echo "⚠️  SwiftLint not found. Run 'make setup' first."; \
	fi

format: ## Format Swift code
	@echo "✨ Formatting Swift code..."
	@if command -v swift-format >/dev/null 2>&1; then \
		find Brixie -name "*.swift" -exec swift-format -i {} \;; \
	else \
		echo "⚠️  swift-format not found. Run 'make setup' first."; \
	fi

format-check: ## Check Swift code formatting
	@echo "🔍 Checking Swift code formatting..."
	@if command -v swift-format >/dev/null 2>&1; then \
		swift-format lint --recursive Brixie; \
	else \
		echo "⚠️  swift-format not found. Run 'make setup' first."; \
	fi

# Documentation
docs: ## Generate documentation
	@echo "📚 Generating documentation..."
	@cd Brixie && xcodebuild docbuild -project Brixie.xcodeproj -scheme Brixie -destination "generic/platform=iOS Simulator"

docs-serve: ## Serve documentation locally
	@echo "🌐 Starting documentation server..."
	@if [ -d "docs" ]; then \
		cd docs && python3 -m http.server 8080; \
	else \
		echo "⚠️  Documentation not found. Run 'make docs' first."; \
	fi

# Docker support
docker-up: ## Start development services
	@echo "🐳 Starting development services..."
	@docker-compose up -d

docker-down: ## Stop development services
	@echo "🐳 Stopping development services..."
	@docker-compose down

docker-logs: ## Show logs from development services
	@docker-compose logs -f

# Cleaning
clean: ## Clean build artifacts
	@echo "🧹 Cleaning build artifacts..."
	@cd Brixie && xcodebuild clean -project Brixie.xcodeproj -scheme Brixie
	@rm -rf Brixie/build
	@rm -rf Brixie/DerivedData

clean-all: clean ## Clean everything including dependencies
	@echo "🧹 Deep cleaning..."
	@rm -rf ~/Library/Developer/Xcode/DerivedData/Brixie-*

# Release management
archive: ## Create archive for distribution
	@echo "📦 Creating archive..."
	@cd Brixie && xcodebuild -project Brixie.xcodeproj -scheme Brixie -configuration Release -destination "generic/platform=iOS" archive -archivePath build/Brixie.xcarchive

# CI/CD simulation
ci-all: lint format-check test build ## Run all CI checks locally
	@echo "✅ All CI checks passed!"

# Quick development workflow
dev: clean lint test build ## Quick development workflow
	@echo "🚀 Development workflow complete!"

# Version management
version: ## Show current version info
	@echo "📱 Brixie Version Information"
	@echo "============================"
	@if [ -f "Brixie/Brixie/Info.plist" ]; then \
		echo "Bundle Version: $$(plutil -extract CFBundleVersion raw Brixie/Brixie/Info.plist 2>/dev/null || echo 'Not found')"; \
		echo "Bundle Short Version: $$(plutil -extract CFBundleShortVersionString raw Brixie/Brixie/Info.plist 2>/dev/null || echo 'Not found')"; \
	else \
		echo "Info.plist not found"; \
	fi
	@echo "Git Commit: $$(git rev-parse --short HEAD 2>/dev/null || echo 'Not a git repository')"
	@echo "Git Branch: $$(git branch --show-current 2>/dev/null || echo 'Not a git repository')"
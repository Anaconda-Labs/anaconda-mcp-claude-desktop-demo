#!/bin/bash
# Anaconda MCP Demo Setup Script
# This script prepares your system for running the Anaconda MCP demo

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Demo configuration
DEMO_ENV_NAME="anaconda-mcp-demo"
REQUIRED_PYTHON_VERSION="3.13"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         Anaconda MCP Demo Setup Script                        ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to print status messages
print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  STEP 1: Checking Prerequisites"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check for conda
print_status "Checking for conda..."
if command_exists conda; then
    CONDA_VERSION=$(conda --version)
    print_success "Found conda: $CONDA_VERSION"
else
    print_error "conda is not installed or not in PATH"
    echo ""
    echo "Please install conda from:"
    echo "  • Miniconda: https://docs.conda.io/en/latest/miniconda.html"
    echo "  • Anaconda: https://www.anaconda.com/download"
    echo ""
    exit 1
fi

# Initialize conda for bash/zsh if needed
if [ -z "$CONDA_EXE" ]; then
    print_warning "Conda not initialized in current shell"
    print_status "Attempting to initialize conda..."

    # Try to source conda
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        source "$HOME/miniconda3/etc/profile.d/conda.sh"
        print_success "Initialized conda from miniconda3"
    elif [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        source "$HOME/anaconda3/etc/profile.d/conda.sh"
        print_success "Initialized conda from anaconda3"
    elif [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        source "/opt/conda/etc/profile.d/conda.sh"
        print_success "Initialized conda from /opt/conda"
    else
        print_warning "Could not auto-initialize conda. You may need to run:"
        echo "  conda init $(basename $SHELL)"
        echo "  Then restart your terminal and re-run this script"
    fi
fi

# Check for Claude Desktop (OS-specific)
print_status "Checking for Claude Desktop..."
CLAUDE_FOUND=false
case "$(uname -s)" in
    Darwin)
        if [ -d "/Applications/Claude.app" ]; then
            print_success "Found Claude Desktop (macOS)"
            CLAUDE_FOUND=true
        fi
        CLAUDE_CONFIG_PATH="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
        ;;
    Linux)
        # Check common Linux install locations
        if command_exists claude || [ -f "$HOME/.local/bin/claude" ]; then
            print_success "Found Claude Desktop (Linux)"
            CLAUDE_FOUND=true
        fi
        CLAUDE_CONFIG_PATH="$HOME/.config/Claude/claude_desktop_config.json"
        ;;
    CYGWIN*|MINGW*|MSYS*)
        CLAUDE_CONFIG_PATH="$APPDATA/Claude/claude_desktop_config.json"
        if [ -f "$CLAUDE_CONFIG_PATH" ]; then
            print_success "Found Claude Desktop config (Windows)"
            CLAUDE_FOUND=true
        fi
        ;;
esac

if [ "$CLAUDE_FOUND" = false ]; then
    print_warning "Claude Desktop not detected"
    echo "  Download from: https://claude.ai/download"
    echo "  (You can continue setup and install Claude Desktop later)"
    echo ""
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  STEP 2: Creating Demo Environment"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if demo environment already exists
if conda env list | grep -q "^${DEMO_ENV_NAME} "; then
    print_warning "Environment '$DEMO_ENV_NAME' already exists"
    read -p "Do you want to recreate it? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Removing existing environment..."
        conda env remove -n "$DEMO_ENV_NAME" -y
        print_success "Environment removed"
    else
        print_status "Using existing environment"
        ENV_EXISTS=true
    fi
fi

if [ "$ENV_EXISTS" != true ]; then
    print_status "Creating environment '$DEMO_ENV_NAME' with Python $REQUIRED_PYTHON_VERSION..."
    conda create -n "$DEMO_ENV_NAME" python="$REQUIRED_PYTHON_VERSION" -y
    print_success "Environment created"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  STEP 3: Installing anaconda-mcp"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Activate the demo environment
print_status "Activating environment '$DEMO_ENV_NAME'..."
eval "$(conda shell.bash hook)"
conda activate "$DEMO_ENV_NAME"
print_success "Environment activated"

# Install anaconda-mcp from conda
print_status "Installing anaconda-mcp from conda..."
conda install -c anaconda anaconda-mcp -y
print_success "anaconda-mcp installed"

# Install environments-mcp-server (required for conda tools)
print_status "Installing environments-mcp-server from conda..."
conda install -c anaconda environments-mcp-server -y
print_success "environments-mcp-server installed"

# Verify installation
print_status "Verifying installation..."
if command_exists anaconda-mcp; then
    AMCP_VERSION=$(anaconda-mcp --help | head -n 1 || echo "anaconda-mcp")
    print_success "anaconda-mcp is installed and working"
else
    print_error "anaconda-mcp installation failed"
    exit 1
fi

# Verify environments-mcp-server
if python -m environments_mcp_server --help >/dev/null 2>&1; then
    print_success "environments-mcp-server is installed and working"
else
    print_warning "environments-mcp-server may not be installed correctly"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  STEP 4: Configuring Claude Desktop"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "$CLAUDE_FOUND" = true ]; then
    print_status "Configuring Claude Desktop integration..."

    # Check if already configured
    if [ -f "$CLAUDE_CONFIG_PATH" ] && grep -q "anaconda-mcp" "$CLAUDE_CONFIG_PATH" 2>/dev/null; then
        print_warning "Claude Desktop already has anaconda-mcp configured"
        read -p "Reconfigure? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            anaconda-mcp claude-desktop setup-config --force
            print_success "Claude Desktop reconfigured"
        else
            print_status "Keeping existing configuration"
        fi
    else
        anaconda-mcp claude-desktop setup-config
        print_success "Claude Desktop configured"
    fi

    # Add filesystem server for demo directory access
    print_status "Configuring filesystem access for demo..."
    DEMO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Check if filesystem server is already configured
    if grep -q "@modelcontextprotocol/server-filesystem" "$CLAUDE_CONFIG_PATH" 2>/dev/null; then
        print_warning "Filesystem server already configured"
    else
        # Add filesystem server to config
        python3 -c "
import json
import sys

config_path = '$CLAUDE_CONFIG_PATH'
demo_dir = '$DEMO_DIR'

try:
    with open(config_path, 'r') as f:
        config = json.load(f)

    if 'mcpServers' not in config:
        config['mcpServers'] = {}

    # Add filesystem server
    config['mcpServers']['filesystem'] = {
        'command': 'npx',
        'args': ['-y', '@modelcontextprotocol/server-filesystem', demo_dir]
    }

    with open(config_path, 'w') as f:
        json.dump(config, f, indent=2)

    print('Filesystem server added')
    sys.exit(0)
except Exception as e:
    print(f'Error: {e}', file=sys.stderr)
    sys.exit(1)
"
        if [ $? -eq 0 ]; then
            print_success "Filesystem server configured for: $DEMO_DIR"
        else
            print_warning "Could not configure filesystem server automatically"
            echo "You can add it manually later (see README.md)"
        fi
    fi

    echo ""
    print_warning "IMPORTANT: You must restart Claude Desktop for changes to take effect"
    echo "  1. Quit Claude Desktop completely"
    echo "  2. Reopen Claude Desktop"
    echo "  3. Look for tools with 'conda_' prefix and filesystem access"
else
    print_warning "Skipping Claude Desktop configuration (not detected)"
    echo ""
    echo "After installing Claude Desktop, run:"
    echo "  conda activate $DEMO_ENV_NAME"
    echo "  anaconda-mcp claude-desktop setup-config"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  STEP 5: Verifying Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

print_status "Running verification checks..."
echo ""

# Check environment
if conda env list | grep -q "^${DEMO_ENV_NAME} "; then
    print_success "Demo environment exists: $DEMO_ENV_NAME"
else
    print_error "Demo environment not found"
fi

# Check anaconda-mcp command
if command_exists anaconda-mcp; then
    print_success "anaconda-mcp command is available"
else
    print_error "anaconda-mcp command not found"
fi

# Check Claude Desktop config
if [ -f "$CLAUDE_CONFIG_PATH" ]; then
    print_success "Claude Desktop config exists"
    if grep -q "anaconda-mcp" "$CLAUDE_CONFIG_PATH" 2>/dev/null; then
        print_success "anaconda-mcp is in Claude Desktop config"
    else
        print_warning "anaconda-mcp not found in Claude Desktop config"
    fi
else
    print_warning "Claude Desktop config not found at: $CLAUDE_CONFIG_PATH"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Setup Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

print_success "Demo environment is ready!"
echo ""
echo "Next Steps:"
echo ""
echo "  1. Restart Claude Desktop (quit and reopen)"
echo "  2. Open demo/demo_walkthrough.md for step-by-step scenarios"
echo "  3. Start chatting with Claude about conda environments!"
echo ""
echo "Quick verification in Claude Desktop:"
echo "  - Look for tools starting with 'conda_'"
echo "  - Try: 'List my conda environments'"
echo "  - Try: 'Create an environment called test-demo with Python 3.11'"
echo ""
echo "For troubleshooting, see: demo/README.md"
echo ""

# Optional: Test server manually
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Optional: Test Server Manually"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
read -p "Would you like to test the MCP server manually? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    print_status "Starting anaconda-mcp server in verbose mode..."
    echo ""
    echo "The server will start and display log output."
    echo "This is useful for debugging but NOT needed for Claude Desktop."
    echo ""
    echo "To stop the server:"
    echo "  • Press Ctrl+C, then hit Enter"
    echo ""
    echo "Starting in 3 seconds..."
    sleep 3
    echo ""
    anaconda-mcp -v serve
fi

echo ""
print_success "Setup complete! Happy demoing!"
echo ""

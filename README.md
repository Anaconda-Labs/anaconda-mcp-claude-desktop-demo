# Anaconda MCP Demo using Claude Desktop

**Status:** Active | Last tested: 2026-04-06

Welcome to the Anaconda MCP demo! This interactive demonstration shows how Claude Desktop can manage conda environments through natural language using the Model Context Protocol (MCP).

## What This Demo Shows

How AI assistants can help data scientists and developers:

- **Create conda environments** for specific projects with natural language
- **Install and manage packages** without remembering conda syntax
- **Inspect and list environments** to understand what's installed
- **Clean up environments** when projects are complete

All through conversational interactions with Claude Desktop.

---

## Why This Matters

Managing conda environments is a common bottleneck in data science workflows. Setting up environments, installing packages, and troubleshooting dependency conflicts can consume hours per project for developers unfamiliar with conda syntax.

**The Problem:**
- Conda commands require memorizing specific syntax and flags
- Error messages can be cryptic for newcomers
- Environment conflicts waste hours of troubleshooting
- Teams struggle with inconsistent environment setups

**How Anaconda MCP Solves It:**
Anaconda MCP enables natural language environment management through Claude Desktop. Instead of learning conda commands, you describe what you need in plain English, and the AI handles the technical details.

**Benefits:**
- **Reduces environment setup time** 
- **Enables non-experts** to manage environments confidently within minutes
- **Improves team consistency** through conversational environment specification

This demo shows these benefits through four realistic scenarios, each taking 3-5 minutes to complete.

---

## Prerequisites

Before running this demo, you'll need:

### Required
- **Conda** (Miniconda or Anaconda Distribution)
  - Install from: https://docs.conda.io/en/latest/miniconda.html
  - Verify: `conda --version`

- **Claude Desktop**
  - Download from: https://claude.ai/download
  - Must have an Anthropic account

- **anaconda-mcp package**
  - Installed automatically by setup script
  - Or manually: `conda install -c anaconda anaconda-mcp`

### Optional
- **Jupyter** (for notebook demo scenario)
- **Terminal** access (to verify AI actions)

---

## Get Started

### Option 1: Automated Setup (Recommended)

```bash
cd ~/Documents/anaconda-mcp-demo
./setup.sh
```

This script will:
1. Check all prerequisites
2. Create a dedicated demo environment
3. Configure Claude Desktop
4. Provide next steps

### Option 2: Manual Setup

```bash
# 1. Create demo environment
conda create -n anaconda-mcp-demo python=3.13
conda activate anaconda-mcp-demo

# 2. Install packages from anaconda channel
conda install -c anaconda anaconda-mcp environments-mcp-server

# 3. Configure Claude Desktop
anaconda-mcp claude-desktop setup-config

# 4. Add filesystem access (edit claude_desktop_config.json)
# See "Filesystem Access" section below for instructions

# 5. Restart Claude Desktop
# (Quit and reopen the application)
```

---

## Running the Demo

### Step 1: Verify Installation

*Quit* then re-open Claude Desktop and check that Anaconda MCP tools are available:

1. Quit Claude Desktop if it's running (don't just close the window)
2. Open Claude Desktop
3. Navigate to Settings > Developer > Local MCP Servers (anaconda-mcp should be running)
4. Click on the "+" icon when starting a new chat then select "Connectors" (you should see anaconda-mcp and filesystem toggled to on)

### Step 2: Follow the Walkthrough

Open [demo_walkthrough.md](demo_walkthrough.md) and follow the scenarios step-by-step. The scenarios include:
- **Natural language prompt** to send to Claude
- **Expected behavior** from the AI
- **Verification steps** to confirm in your terminal
- **Common issues** and how to resolve them

### Step 3: Try Your Own Scenarios

After completing the walkthrough, try your own environment management tasks!

---

## Demo Scenarios

This demo includes three progressive scenarios:

1. **The Messy Script** - Get unfamiliar code running without import resolution headaches
2. **The Package Explorer** - List and inspect environments and packages
3. **The Cleanup Crew** - Safely remove environments

📖 **For complete step-by-step instructions, see [demo_walkthrough.md](demo_walkthrough.md)**

---

## Messy Scripts Collection

The `messy_scripts/` directory contains realistic "found code" scenarios—scripts downloaded from GitHub, received from colleagues, or AI-generated. No requirements.txt, no environment.yml, just imports that need to work.

**Scripts included:**
- `image_analyzer.py` - Image processing with opencv, scikit-learn, pillow
- `data_pipeline.py` - ML pipeline with xgboost, lightgbm, pandas

See [messy_scripts/README.md](messy_scripts/README.md) for details.

---

## Sample Project

The `sample_project/` directory contains a structured ML project with customer transaction data and a Jupyter notebook. Use this for a traditional "create environment from yml" workflow.

---

## Filesystem Access

The setup script automatically configures Claude Desktop to access the demo directory. This allows Claude to:
- Read `environment.yml` files from the sample project
- Browse sample data files
- Access Jupyter notebooks

### Working with Your Own Projects

To give Claude access to your own project directories, edit your Claude Desktop configuration:

**macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`  
**Windows:** `%APPDATA%\Claude\claude_desktop_config.json`  
**Linux:** `~/.config/Claude/claude_desktop_config.json`

Add or modify the `filesystem` server to point to your project:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/your/project"
      ]
    }
  }
}
```

**Multiple directories:**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/project1",
        "/path/to/project2"
      ]
    }
  }
}
```

**After making changes:** Quit and reopen Claude Desktop for changes to take effect.

**Security Note:** Only grant access to directories you trust. Claude will be able to read (but not write) files in these directories.

---

## Troubleshooting

### Claude Desktop doesn't show Anaconda MCP tools

**Solution**:
```bash
# 1. Verify configuration
anaconda-mcp claude-desktop show

# 2. Check if anaconda-mcp is in the config
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json

# 3. Reconfigure if needed
anaconda-mcp claude-desktop setup-config --force

# 4. Fully restart Claude Desktop (quit and reopen)
```

### Port collision errors

If you see `Address already in use` errors in Claude Desktop logs:

- Check what's using port 4041 (environments-mcp-server).  
```bash
lsof -i :4041
```
You should see one python process using port 4041.    
If you see multiple processes or a different program, that may be a conflict.   

**Common causes and solutions:**

If you manually started anaconda-mcp server:   
- Press `Ctrl+C` in that terminal to stop it, then restart Claude Desktop.   

If another process is using port 4041:    
- Stop that process, then restart Claude Desktop    

Verify Claude Desktop can start the servers   
- Quit and reopen Claude Desktop 
- Check Settings > Developer > Local MCP Servers (should show anaconda-mcp running)   

**Note:** Claude Desktop connects to anaconda-mcp via STDIO (no network port needed). The anaconda-mcp gateway then starts environments-mcp-server on port 4041. You should only see port 4041 in use when everything is working correctly.

### Authentication issues

```bash
# Check if you're logged in
anaconda auth whoami

# Login if needed (optional - auth is disabled by default)
anaconda auth login
```

### Environments not found

If the AI can't find environments:

```bash
# Verify environments exist
conda env list

# Check conda configuration
conda config --show envs_dirs

# Ensure you're using the right conda
which conda
```

### Tool calls fail silently

```bash
# Run server manually with verbose logging
anaconda-mcp -v serve

# Check Claude Desktop MCP logs
# (Help → Open MCP Log File in Claude Desktop)
```

---

## Resources

- **MCP Specification**: https://modelcontextprotocol.io
- **Claude Desktop**: https://claude.ai/download
- **Conda Documentation**: https://docs.conda.io

---

## Feedback

Found an issue or have a suggestion? Please report it at:
https://github.com/anaconda/anaconda-mcp/issues

---

## Owner

**Daina Bouquin** ([@dbouquin](https://github.com/dbouquin))

---

## License

This demo is licensed under the MIT License. See [LICENSE](LICENSE) file for details.

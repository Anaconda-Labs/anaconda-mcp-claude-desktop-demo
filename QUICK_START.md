# Quick Start Guide

Get the Anaconda MCP demo running in 5 minutes.

---

## Prerequisites

- **Conda** installed (Miniconda or Anaconda)
- **Claude Desktop** installed ([download](https://claude.ai/download))
- **macOS, Linux, or Windows**

---

## Setup (One Command)

```bash
cd ~/Documents/anaconda-mcp-demo  # Or wherever you cloned this
./setup.sh
```

**What it does:**
- ✅ Checks prerequisites
- ✅ Creates `anaconda-mcp-demo` environment
- ✅ Installs `anaconda-mcp` + `environments-mcp-server`
- ✅ Configures Claude Desktop (anaconda-mcp + filesystem access)
- ✅ Verifies everything works

**Time:** ~5 minutes

---

## Required: Restart Claude Desktop

⚠️ **Critical Step:**
1. Quit Claude Desktop completely (Cmd+Q / close app)
2. Reopen Claude Desktop
3. Wait 10 seconds for servers to start

---

## Verify It Works

### Check Configuration
1. Open Claude Desktop
2. Go to **Settings → Developer → Local MCP Servers**
3. Verify `anaconda-mcp` shows as **running**

### Check Connectors
Start a new chat and click the **"+"** icon:
1. Select **Connectors**
2. Verify `anaconda-mcp` and `filesystem` are both toggled **ON**

### Test the Tools
In your chat, send:
```
List all my conda environments
```

Claude should automatically call the tools and show your environments.

---

## Next Steps

Once verified: **Follow the demo**: Open `demo_walkthrough.md` for 3 progressive scenarios

---

## Troubleshooting

**Tools don't appear?**
→ See [README.md - Troubleshooting section](README.md#troubleshooting)

**Filesystem not working?**
→ Verify filesystem connector is enabled (see "Check Connectors" above)

**Port conflicts?**
→ See [README.md - Port collision errors](README.md#port-collision-errors)

**Other issues?**
→ Check the full [README.md](README.md) for comprehensive troubleshooting

---

## That's It!

Three steps:
1. Run `./setup.sh`
2. Restart Claude Desktop
3. Verify connectors are enabled

**Then open `demo_walkthrough.md` and start with "The Messy Script" scenario!**

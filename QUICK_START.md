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
- ✅ Configures Claude Desktop
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

### Test the Tools
Start a new chat and send:
```
List all my conda environments
```

Claude should automatically call the tools and show your environments.

---

## Next Steps

Once verified:

1. **Follow the demo**: Open `demo_walkthrough.md` for 4 complete scenarios
2. **Try the sample project**: Explore `sample_project/` for ML analysis example

---

## Troubleshooting

**Tools don't appear?**
→ See [README.md - Troubleshooting section](README.md#troubleshooting)

**Port conflicts?**
→ See [README.md - Port collision errors](README.md#port-already-in-use-port-collision)

**Setup script fails?**
→ See [README.md - Setup script fails](README.md#setup-script-fails)

**Other issues?**
→ Check the full [README.md](README.md) for comprehensive troubleshooting

---

## File Guide

| File | What It Is |
|------|------------|
| **QUICK_START.md** | This file - fastest path to working demo |
| **README.md** | Complete documentation, all scenarios, troubleshooting |
| **demo_walkthrough.md** | Step-by-step through 4 demo scenarios |
| **setup.sh** | Automated setup script |
| **sample_project/** | ML project example with Jupyter notebook |

---

## That's It!

Three steps:
1. Run `./setup.sh`
2. Restart Claude Desktop
3. Test with "List all my conda environments"

**Then open `demo_walkthrough.md` and start the demo!**

---

**Having issues?** Check [README.md](README.md) for comprehensive troubleshooting.

**Questions?** Open an issue: https://github.com/anaconda/anaconda-mcp/issues

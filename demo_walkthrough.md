# Anaconda MCP Demo Walkthrough

This guide walks you through four scenarios demonstrating Anaconda MCP's capabilities. Each scenario includes the prompt to send to Claude, expected behavior, and verification steps.

**Prerequisites**: Complete `setup.sh` and restart Claude Desktop before beginning.

---

## Table of Contents

1. [Scenario 1: The New Data Scientist](#scenario-1-the-new-data-scientist)
2. [Scenario 2: The Package Explorer](#scenario-2-the-package-explorer)
3. [Scenario 3: The Troubleshooter](#scenario-3-the-troubleshooter)
4. [Scenario 4: The Cleanup Crew](#scenario-4-the-cleanup-crew)
5. [Advanced Scenarios](#advanced-scenarios)
6. [Tips for Success](#tips-for-success)

---

## Before You Begin

### Verify Installation

In Claude Desktop, make sure "anaconda-mcp" shows up as a Connector and turned onn when you click "+" in a new chat window

If you don't see anaconda-mcp, revisit the [Troubleshooting section](README.md#troubleshooting) in the main README.

### Open Two Windows

For the best demo experience:
1. **Claude Desktop** - For conversing with the AI
2. **Terminal** - For verifying conda operations (Optional but recommended)

---

## Scenario 1: The New Data Scientist

**Goal**: Create a complete machine learning environment from scratch using natural language.

### Step 1A: Send the Prompt

In Claude Desktop, type:

```
I'm starting a machine learning project to analyze customer data. 
Can you help me set up a conda environment called "ml-customer-analysis" 
using the information available in /Users/dbouquin/Documents/anaconda-mcp-demo/sample_project/environment.yml (*repace this path with the path to your sample project*)
```

### Expected Behavior

Claude should:
1. Acknowledge your request
2. Call `conda_create_environment` with appropriate parameters
3. Confirm the environment was created successfully
4. Provide the path to the new environment

### Verify in Terminal

```bash
# Check that the environment exists
conda env list | grep ml-customer-analysis

# You should see output like:
# ml-customer-analysis     /Users/username/miniconda3/envs/ml-customer-analysis
```

✅ **Success Criteria**: Environment appears in the list with correct Python version

---

### Step 1B: Install Packages

Continue the conversation in Claude Desktop:

```
Great! Now install xgboost.
```

### Expected Behavior

Claude should:
1. Call `conda_install_packages` with the environment name and package list
2. Wait for installation to complete (may take 1-2 minutes)
3. Confirm all packages were installed successfully
4. Provide a summary of what was installed

### Verify in Terminal

```bash
# Check installed packages
conda list -n ml-customer-analysis | grep -E "xgboost"

# You should see all five packages listed with version numbers
```

✅ **Success Criteria**: Requested packages are present in the environment

---

### Step 1C: Get Usage Instructions

Ask Claude:

```
How do I activate this environment and start using it in VSCode?
```
*Note:* Choose your preferred IDE (VSCode, PyCharm, Jupyter, etc.)

### Expected Behavior

Claude should provide clear instructions including:

1. **Activation command** for the terminal:
   ```bash
   conda activate ml-customer-analysis
   ```

2. **VSCode setup steps**:
   - Open Command Palette (Cmd/Ctrl+Shift+P)
   - Search for "Python: Select Interpreter"
   - Choose the `ml-customer-analysis` environment from the list
   - Or manually enter the path: `/path/to/conda/envs/ml-customer-analysis/bin/python`
   
3. **Alternative IDEs** (if asked):
   - **Jupyter**: `jupyter notebook` (after activating environment)
   - **PyCharm**: File → Settings → Project → Python Interpreter → Add → Conda Environment
   - **Terminal only**: Just activate and run `python` or your scripts

### Verify in Terminal

```bash
# Activate the environment
conda activate ml-customer-analysis

# Test that packages work
python -c "import pandas, numpy, sklearn, xgboost; print('Success! All packages imported.')"

# You should see: Success! All packages imported.
```

✅ **Success Criteria**: Environment activates and packages import successfully in your chosen IDE or terminal

---

## Scenario 2: The Package Explorer

**Goal**: Understand what environments exist and what's installed in them.

### Step 2A: List All Environments

In Claude Desktop:

```
What conda environments do I have?
```

### Expected Behavior

Claude should:
1. Call `conda_list_environments`
2. Display a formatted list of all environments including:
   - Environment name
   - Python version
   - Full path
   - Size (if available)
3. Highlight the currently active environment

### Verify in Terminal

```bash
# Compare with conda's output
conda env list

# Should match what Claude reported
```

✅ **Success Criteria**: Claude's list matches `conda env list` output

---

### Step 2B: Inspect Specific Environment

Continue in Claude Desktop:

```
What packages are installed in the ml-customer-analysis environment?
```

### Expected Behavior

Claude should:
1. Call `conda_list_environments` or query specific environment details
2. Show all installed packages with versions
3. Highlight key packages (pandas, numpy, etc.)
4. Mention the total number of packages

### Verify in Terminal

```bash
# Check package count
conda list -n ml-customer-analysis | wc -l

# List all packages
conda list -n ml-customer-analysis

# Compare with what Claude reported
```

✅ **Success Criteria**: Package list is accurate and comprehensive

---

### Step 2C: Compare Environments

Ask Claude:

```
"Can you compare the ml-customer-analysis with <NAME OF ANOTHER ONE OF YOUR ENVIRONMENTS>?"
```

### Expected Behavior

Claude should:
1. Retrieve information about both environments
2. Compare Python versions
3. Highlight unique packages in each
4. Note differences in purpose/size

✅ **Success Criteria**: Claude provides meaningful comparison insights

---

## Scenario 3: The Cleanup Crew

**Goal**: Safely remove environments when no longer needed.

### Step  3A: List Environments Before Cleanup

In Claude Desktop:

```
Show me all my conda environments. Help me get rid of the environments I don't use
```

### Expected Behavior

Claude should:
1. List all environments
2. Identify which ones look like demo/test environments
3. Suggest next steps
4. Successfully remove your selected environments

### Verify in Terminal

```bash
# Check current environments
conda env list

# Note which ones you want to keep
# Rerun after Claude has removed environments to confirm they are no longer listed
```

✅ **Success Criteria**: Claude provides a clear list for review and instructions

---

### Step 4B: Delete a Specific Environment

Continue in Claude Desktop:

```
Delete the ml-customer-analysis environment. I'm done with that project.
```

### Expected Behavior

Claude should:
1. Confirm which environment you want to delete
2. Call `conda_delete_environment`
3. Wait for deletion to complete
4. Confirm successful deletion
5. Note that you can't recover deleted environments

### Verify in Terminal

```bash
# Check that environment is gone
conda env list | grep ml-customer-analysis
# Should return nothing

# Try to activate it (should fail)
conda activate ml-customer-analysis
# Should show error: EnvironmentNotFound
```

✅ **Success Criteria**: Environment is completely removed

---

## Advanced Scenarios

Try these after completing the basic walkthrough:

### Package Version Management

```
Install pandas version 1.5.3 specifically in a new environment called version-test.
```

### Environment Export

```
Export the specifications for the anaconda-mcp-demo environment to a file 
called demo-export.yml so I can recreate it later.
```

### Batch Operations

```
Create three separate environments: one for Python 3.9, one for 3.10, and 
one for 3.11. Name them python-39-test, python-310-test, and python-311-test.
```

### Troubleshooting Assistance

```
My environment isn't working correctly. Can you diagnose what might be wrong 
with the ml-test environment?
```

---

## Common Issues

### Claude doesn't see the tools

**Solution**: 
1. Verify configuration: `anaconda-mcp claude-desktop show`
2. Check Claude Desktop logs (Help → Open MCP Log File)
3. Fully restart Claude Desktop (quit and reopen)

### Tool calls fail silently

**Solution**:
1. Run `anaconda-mcp -v serve` manually to see errors
2. Check for port conflicts: `lsof -i :2391`
3. Verify conda is accessible: `which conda`

### Package installation times out

**Solution**:
1. Large packages like tensorflow can take 5+ minutes
2. The MCP server has timeouts configured
3. Consider installing large packages beforehand

### Environments not found

**Solution**:
1. Check conda configuration: `conda config --show envs_dirs`
2. Verify environments exist: `conda env list`
3. Ensure you're using the right conda: `which conda`

---

## What's Next? Extension Ideas

After completing these scenarios, try building on what you've learned:

### 1. **Multi-Environment Workflows**
- Create separate environments for different project phases
- Switch between development, testing, and production environments
- Share environment specifications with team members

### 2. **Package Discovery**
- Search for packages before installing
- Compare different package versions
- Check package compatibility

### 3. **Environment Templates**
- Create reusable environment templates
- Standard data science stack

### 4. **CI/CD Integration**
- Generate environment yamls for CI pipelines
- Test across multiple Python versions

### 6. **Team Collaboration**
- Export environment specifications
- Document environment setup steps
- Share reproducible environments

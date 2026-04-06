# Anaconda MCP Demo Walkthrough

This guide walks you through three scenarios demonstrating Anaconda MCP's capabilities. Each scenario includes the prompt to send to Claude, expected behavior, and verification steps.

**Prerequisites**: Run `./setup.sh` and restart Claude Desktop before beginning.

---

## Table of Contents

1. [Scenario 1: The Messy Script](#scenario-1-the-messy-script)
2. [Scenario 2: The Package Explorer](#scenario-2-the-package-explorer)
3. [Scenario 3: The Cleanup Crew](#scenario-3-the-cleanup-crew)
4. [Advanced Scenarios](#advanced-scenarios)
5. [Common Issues](#common-issues)
6. [Extension Ideas](#extension-ideas)

---

## Before You Begin

### Verify Installation

In Claude Desktop, make sure "anaconda-mcp" and "filesystem" show up as Connectors and are turned on when you click "+" in a new chat window.

If you don't see these connectors, revisit the [Troubleshooting section](README.md#troubleshooting) in the main README.

### Open Two Windows

For the best demo experience:
1. **Claude Desktop** - For conversing with the AI
2. **Terminal** - For verifying conda operations (Optional but recommended)

---

## Scenario 1: The Messy Script

**The Challenge**: You have a Python script with mysterious imports and no environment specification. It could be from a colleague, downloaded from GitHub, or AI-generated. You just want it to run.

**Goal**: Get the script running in a clean conda environment without manually resolving import → package mappings.

**Why This Matters**: This is the most frustrating 20 minutes of every data scientist's day. Import errors, Stack Overflow searches, conda vs pip confusion, package name mismatches (cv2→opencv, sklearn→scikit-learn). This scenario shows how AI eliminates all of that.

---

### Step 1A: Look at the Script

Open `messy_scripts/image_analyzer.py` in your editor or read it in terminal:

```bash
cat messy_scripts/image_analyzer.py
```

**What you'll see:**
- Imports: `cv2`, `numpy`, `sklearn`, `PIL`, `matplotlib`, `skimage`
- No requirements.txt
- No environment.yml
- No installation instructions
- Just code that "should work"

**The Traditional Problem:**
```bash
$ python image_analyzer.py
ImportError: No module named 'cv2'

$ conda install cv2
ERROR: The following packages are not available from current channels...
```

---

### Step 1B: Ask Claude to Fix It

In Claude Desktop, type:

```
I have a Python script at YOUR_PATH/messy_scripts/image_analyzer.py that I need to run. 
Can you create a conda environment with all the dependencies it needs?
```

### Expected Behavior

Claude should:
1. **Read the script** (using filesystem access)
2. **Identify imports**: cv2, numpy, sklearn, PIL, matplotlib, skimage
3. **Intelligently resolve** import names to conda packages:
   - `cv2` → `opencv` (not opencv-python)
   - `sklearn` → `scikit-learn` (not sklearn)
   - `PIL` → `pillow`
   - `skimage` → `scikit-image`
   - Others map directly (numpy, matplotlib)
4. **Create environment** with a meaningful name like `image-analysis`
5. **Confirm** what was installed

### Verify in Terminal

```bash
# Check the environment was created (update grep if needed)
conda env list | grep image

# You should see something like:
# image-analysis    /path/to/conda/envs/image-analysis
```

✅ **Success Criteria**: Environment exists with a meaningful name

---

### Step 1C: Run the Script

Ask Claude:

```
How do I run this script in the new environment?
```

### Expected Behavior

Claude should provide:
1. **Activation command**:
   ```bash
   conda activate image-analysis
   ```

2. **Run command**:
   ```bash
   python messy_scripts/image_analyzer.py
   ```

3. **Expected output description**:
   - Creates test_image.png
   - Analyzes dominant colors
   - Saves analysis_result.png

### Verify in Terminal

```bash
# Activate the environment
conda activate image-analysis

# Run the script
python3 messy_scripts/image_analyzer.py
```

**Expected output:**
```
Creating test image...
Test image created: test_image.png
Image size: (300, 200)
  return fit_method(estimator, *args, **kwargs)
Dominant colors (RGB):
  Color 1: [  0   0 255]
  Color 2: [255 255   0]
  Color 3: [255   0   0]
  Color 4: [  0 255   0]
  Color 5: [  0   0 255]

Analysis complete! Result saved to 'analysis_result.png'
```

**Visual confirmation:**
- `test_image.png` created
- `analysis_result.png` created with 3-panel visualization

✅ **Success Criteria**: Script runs successfully and produces output files

---

### Step 1D: Try Another Messy Script (Optional)

Want to see it again? Try the data pipeline script:

```
Now do the same for messy_scripts/data_pipeline.py
```

This script uses:
- `xgboost`, `lightgbm` (ML libraries)
- `sklearn`, `scipy` (data science)
- `pandas`, `numpy` (data manipulation)
- `seaborn`, `matplotlib` (visualization)

Claude should create another clean environment and resolve all dependencies.

---

### What Just Happened?

**Without Anaconda MCP:**
1. Run script → ImportError
2. Google "python cv2 install" → wrong package name
3. Google "cv2 conda" → find opencv
4. Install opencv
5. Run again → ImportError on next package
6. Repeat 8 more times

**With Anaconda MCP:**
1. Ask Claude to create environment
2. Claude resolves all imports intelligently
3. Run script

**The intelligence shown:**
- cv2 → opencv (conda name differs from import)
- sklearn → scikit-learn (common naming mismatch)
- PIL → pillow (historical package rename)
- skimage → scikit-image (namespace vs package name)

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
What packages are installed in the image-analysis environment?
```

### Expected Behavior

Claude should:
1. Call `conda_list_environments` or query specific environment details
2. Show all installed packages with versions
3. Highlight key packages (opencv, scikit-learn, pillow, etc.)
4. Mention the total number of packages

### Verify in Terminal

```bash
# Check package count
conda list -n image-analysis | wc -l

# List all packages
conda list -n image-analysis

# Compare with what Claude reported
```

✅ **Success Criteria**: Package list is accurate and comprehensive

---

### Step 2C: Compare Environments

Ask Claude:

```
Can you compare the image-analysis environment with anaconda-mcp-demo?
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

### Step 3A: List Environments Before Cleanup

In Claude Desktop:

```
Show me all my conda environments. I want to clean up environments I don't need anymore.
```

### Expected Behavior

Claude should:
1. List all environments
2. Identify which ones look like demo/test environments
3. Ask which ones you want to keep
4. Provide guidance on safe deletion

### Verify in Terminal

```bash
# Check current environments
conda env list

# Note which ones you want to keep
```

✅ **Success Criteria**: Claude provides a clear list for review

---

### Step 3B: Delete a Specific Environment

Continue in Claude Desktop:

```
Delete the image-analysis environment. I'm done testing that script.
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
conda env list | grep image-analysis
# Should return nothing

# Try to activate it (should fail)
conda activate image-analysis
# Should show error: EnvironmentNotFound
```

✅ **Success Criteria**: Environment is completely removed

**Note**: You can also delete the data-pipeline environment if you created it in Step 1D.

---

## Additional Scenarios

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
I'm getting import errors in my image-analysis environment. 
Can you help me diagnose what might be wrong?
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

## Extension Ideas

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

---

## What's Next? Extension Ideas

After completing these scenarios, try building on what you've learned:

### 1. **Multi-Environment Workflows**
- Create separate environments for different project phases
- Switch between development, testing, and production environments
- Share environment specifications with team members

### 2. **Jupyter Integration**
- Launch Jupyter from AI-managed environments
- Create notebooks in specific environments
- Manage kernel specifications

### 3. **Package Discovery**
- Search for packages before installing
- Compare different package versions
- Check package compatibility

### 4. **Environment Templates**
- Create reusable environment templates
- Standard data science stack
- Web development stack
- Bioinformatics stack

### 5. **CI/CD Integration**
- Generate environment yamls for CI pipelines
- Test across multiple Python versions
- Automate environment validation

### 6. **Team Collaboration**
- Export environment specifications
- Document environment setup steps
- Share reproducible environments

---

## Congratulations! 🎉

You've completed the Anaconda MCP demo and experienced:

✅ **Intelligent import resolution** - Claude resolved cv2→opencv, sklearn→scikit-learn automatically  
✅ **Environment management** - Created, inspected, and cleaned up environments through conversation  
✅ **Time savings** - What took 20+ minutes of Stack Overflow searches took 30 seconds  
✅ **Real-world workflow** - Ran actual code with messy dependencies

### Key Takeaways

**What you learned:**
- How to use AI to resolve package dependencies intelligently
- Natural language environment management through Claude Desktop
- How MCP connects AI assistants to conda operations
- The difference between import names and conda package names

**Time saved per task:**
- Script dependency resolution: 20+ minutes → 30 seconds
- Environment creation: 5-10 minutes → 1 minute
- Package inspection: 3-5 minutes → 30 seconds

**Real-world impact:**
This demo showed a daily frustration point for data scientists and developers. Every "messy script" scenario—code from GitHub, colleague's notebooks, AI-generated code—can now be handled instantly instead of requiring tribal knowledge about package naming conventions.

---

## Feedback

What worked well? What was confusing? Let us know:
- GitHub Issues: https://github.com/anaconda/anaconda-mcp/issues
- Documentation: Suggest improvements to this walkthrough

---

**Happy environment managing! 🚀**

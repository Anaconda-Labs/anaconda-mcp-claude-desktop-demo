# ML Customer Analysis - Sample Project

This is a sample machine learning project structure for demonstrating Anaconda MCP capabilities.

## Project Overview

**Goal**: Analyze customer purchase patterns to identify high-value segments

**Dataset**: Sample customer transaction data (demo/sample_project/data/sample_data.csv)

**Approach**: 
- Exploratory data analysis
- Feature engineering
- Clustering analysis
- Visualization of customer segments

## Environment Setup

### Using Anaconda MCP with Claude Desktop

The easiest way to set up this project's environment:

1. Open Claude Desktop (with Anaconda MCP configured)
2. Say: *"Create a conda environment from the environment.yml file in ~/Documents/anaconda-mcp-demo/sample_project/"* (replace this location with your actual location
3. Claude will handle the rest!

### Traditional Method

```bash
# Create environment from specification
conda env create -f environment.yml

# Activate environment
conda activate ml-customer-analysis

# Verify installation
python -c "import pandas, numpy, sklearn; print('All packages working')"
```

## Project Structure

```
sample_project/
├── README.md                    # This file
├── environment.yml              # Conda environment specification
├── data/
│   └── sample_data.csv         # Customer transaction data
└── notebooks/
    └── analysis_starter.ipynb  # Jupyter notebook with starter code
```

## Dataset Description

**File**: `data/sample_data.csv`

**Columns**:
- `customer_id`: Unique customer identifier
- `purchase_date`: Date of transaction
- `product_category`: Category of purchased product
- `purchase_amount`: Transaction amount in USD
- `customer_age`: Customer age
- `customer_location`: City/region

**Size**: 1,000 sample transactions

**Use Case**: Suitable for demonstrating:
- Data loading and exploration with pandas
- Basic statistics and visualizations
- Clustering customers by behavior
- Feature engineering

## Getting Started

### 1. Activate Environment

```bash
conda activate ml-customer-analysis
```

### 2. Launch Jupyter

```bash
jupyter notebook
```

### 3. Open Starter Notebook

Navigate to `notebooks/analysis_starter.ipynb` and follow the analysis steps.

## Demo Scenarios

This sample project is perfect for demonstrating:

### Scenario A: Environment from Specification
*"Create an environment from this project's environment.yml file"*

### Scenario B: Adding Packages
*"I need to add seaborn for better visualizations to my ml-customer-analysis environment"*

### Scenario C: Environment Export
*"Export the ml-customer-analysis environment specifications so my team can reproduce it"*

### Scenario D: Jupyter Integration
*"Activate the ml-customer-analysis environment and start a Jupyter notebook server"*

## Analysis Tasks

Try these analysis tasks (with or without AI assistance):

1. **Data Exploration**
   - Load the CSV file
   - Check for missing values
   - Calculate summary statistics

2. **Customer Segmentation**
   - Group customers by total spend
   - Identify high-value customers (top 20%)
   - Analyze purchase patterns by segment

3. **Visualization**
   - Plot purchase amount distribution
   - Show customer age distribution
   - Visualize product category popularity

4. **Feature Engineering**
   - Calculate total purchases per customer
   - Compute average purchase amount
   - Create customer lifetime value (CLV) estimates

5. **Clustering**
   - Use k-means to find customer segments
   - Determine optimal number of clusters
   - Visualize clusters in 2D using PCA

## Expected Insights

After analysis, you should discover:
- 3-4 distinct customer segments
- Correlation between age and purchase category
- Seasonal purchase patterns (if dates span seasons)
- High-value customer characteristics

## Extending This Project

### Add More Data
- Additional customer demographics
- Product details and descriptions
- Customer reviews or ratings
- Marketing campaign data

### Try Different Models
- Classification (predict high-value customers)
- Regression (predict purchase amounts)
- Time series (forecast future purchases)
- Recommendation systems

### Enhance Visualizations
- Interactive plots with plotly
- Dashboards with streamlit
- Geographic visualizations with folium

## Troubleshooting

### Import Errors

If you see `ModuleNotFoundError`:
```bash
# Verify environment is activated
conda env list | grep "*"

# Check if package is installed
conda list | grep <package_name>

# Install missing package
conda install <package_name>
```

### Jupyter Kernel Issues

If Jupyter doesn't see your environment:
```bash
# Install ipykernel
conda install ipykernel

# Register environment as kernel
python -m ipykernel install --user --name ml-customer-analysis --display-name "Python (ML Customer Analysis)"
```

### Data Loading Issues

If CSV doesn't load:
```python
import pandas as pd
import os

# Check file exists
data_path = "data/sample_data.csv"
print(f"File exists: {os.path.exists(data_path)}")

# Try loading with explicit path
df = pd.read_csv(data_path)
```

## Resources

- **Pandas Documentation**: https://pandas.pydata.org/docs/
- **Scikit-learn Guide**: https://scikit-learn.org/stable/user_guide.html
- **Matplotlib Tutorials**: https://matplotlib.org/stable/tutorials/index.html
- **Jupyter Documentation**: https://jupyter-notebook.readthedocs.io/

## License

This sample project is provided for demonstration purposes as part of the Anaconda MCP demo.
Feel free to use, modify, and extend it for your own projects.

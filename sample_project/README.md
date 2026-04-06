# ML Customer Analysis - Sample Project

This is a sample machine learning project demonstrating a structured approach with environment specifications and data.

## Project Overview

**Goal**: Analyze customer purchase patterns to identify high-value segments

**Dataset**: Sample customer transaction data (`data/sample_data.csv`)

**Approach**: 
- Exploratory data analysis
- Feature engineering
- Clustering analysis
- Visualization of customer segments

---

## Quick Start

### Create Environment

```bash
# From this directory
conda env create -f environment.yml

# Activate
conda activate ml-customer-analysis
```

**Or ask Claude Desktop:**
```
Create a conda environment from the environment.yml in sample_project/
```

### Launch Analysis

```bash
# Start Jupyter
jupyter notebook

# Open notebooks/analysis_starter.ipynb
```

---

## Project Structure

```
sample_project/
├── README.md                    # This file
├── environment.yml              # Conda environment specification
├── data/
│   └── sample_data.csv         # Customer transaction data (100 rows)
└── notebooks/
    └── analysis_starter.ipynb  # Jupyter notebook with analysis
```

---

## Dataset

**File**: `data/sample_data.csv`

**Size**: 94 transactions from 50 unique customers (Q1 2026)

**Columns**:
- `customer_id`: Unique identifier (C001-C050)
- `purchase_date`: Transaction date (January-April 2026)
- `product_category`: Electronics, Clothing, Home & Garden, Books, Shoes
- `purchase_amount`: Amount in USD ($19.99 - $899.99)
- `customer_age`: Customer age (24-52 years)
- `customer_location`: US cities (Seattle, Portland, San Francisco, etc.)

**Note**: This is synthetic data for demonstration purposes.

---

## Analysis Tasks

The Jupyter notebook (`notebooks/analysis_starter.ipynb`) walks through:

1. **Load and Explore Data** - Import CSV, check shape, data types, summary statistics
2. **Data Cleaning and Preparation** - Convert dates, check for missing values
3. **Exploratory Data Analysis** - Visualize purchase amounts, product categories, age distribution
4. **Customer Behavior Analysis** - Aggregate by customer, identify high-value customers (top 20% by spend)
5. **Customer Segmentation** - K-means clustering with optimal k selection (elbow method)
6. **Visualize Clusters** - PCA visualization, box plots comparing clusters
7. **Insights and Recommendations** - Summarize findings, suggest next steps

**Key Findings**:
- Average customer lifetime value: ~$414
- Three distinct customer segments identified
- High-value customers (Cluster 2) spend ~$1,036 on average

---

## Using with the Demo

This project is referenced in the main demo as an example of a **structured project** with proper environment specifications. It contrasts with the "messy scripts" that have no environment files.

See [../demo_walkthrough.md](../demo_walkthrough.md) for the complete demo including this project.

---

## Extending This Project

Ideas for further exploration:

- **More data**: Add demographics, reviews, campaign data
- **Different models**: Classification, regression, time series, recommendations
- **Better visualizations**: plotly, streamlit dashboards, geographic maps

---

## Troubleshooting

### Import Errors

```bash
# Verify environment is activated
conda env list | grep "*"

# Check packages
conda list
```

### Jupyter Kernel Issues

```bash
# Register environment as Jupyter kernel
conda install ipykernel
python -m ipykernel install --user --name ml-customer-analysis
```

---

## Resources

- **Pandas**: https://pandas.pydata.org/docs/
- **Scikit-learn**: https://scikit-learn.org/stable/
- **Matplotlib**: https://matplotlib.org/stable/tutorials/
- **Jupyter**: https://jupyter-notebook.readthedocs.io/

---

**Part of the Anaconda MCP Demo** - See [../README.md](../README.md) for complete documentation.

# Messy Scripts Collection

This directory contains "found code" scenarios—Python scripts with dependencies but no environment specifications.

## The Scripts

### image_analyzer.py

**What it does:** Analyzes images to find dominant colors and detect edges

**Key imports:** cv2, sklearn, PIL, skimage, matplotlib

**The challenge:** Import names don't match conda package names (cv2→opencv, sklearn→scikit-learn, PIL→pillow, skimage→scikit-image)

---

### data_pipeline.py

**What it does:** Trains XGBoost and LightGBM models on synthetic data

**Key imports:** xgboost, lightgbm, sklearn, scipy, pandas, seaborn

**The challenge:** Mix of ML and data science libraries with varying naming conventions

---

## Usage

See [demo_walkthrough.md](../demo_walkthrough.md) for step-by-step instructions on using these scripts with Claude Desktop.

The demo shows how Claude can read these scripts and automatically create conda environments with the correct package mappings, eliminating the need to manually resolve import→package name mismatches.

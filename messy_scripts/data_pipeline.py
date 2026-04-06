"""
Data Processing Pipeline - from a colleague's experiment
No environment info, just 'it worked on my machine'
"""

import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
import xgboost as xgb
import lightgbm as lgb
from scipy import stats
import seaborn as sns
import matplotlib.pyplot as plt


def load_and_clean_data():
    """Create and clean sample dataset."""
    np.random.seed(42)

    # Generate synthetic data
    n_samples = 1000
    data = {
        'feature_1': np.random.randn(n_samples),
        'feature_2': np.random.randn(n_samples) * 2 + 5,
        'feature_3': np.random.randint(1, 100, n_samples),
        'category': np.random.choice(['A', 'B', 'C'], n_samples),
    }

    df = pd.DataFrame(data)

    # Add target variable
    df['target'] = (
        df['feature_1'] * 2 +
        df['feature_2'] * 0.5 +
        df['feature_3'] * 0.01 +
        np.random.randn(n_samples) * 5
    )

    print(f"Dataset shape: {df.shape}")
    print(f"\nFirst few rows:\n{df.head()}")

    return df


def preprocess_features(df):
    """Preprocess and scale features."""
    # Remove outliers using z-score
    z_scores = np.abs(stats.zscore(df.select_dtypes(include=[np.number])))
    df_clean = df[(z_scores < 3).all(axis=1)]

    print(f"\nRemoved {len(df) - len(df_clean)} outliers")

    # One-hot encode categories
    df_encoded = pd.get_dummies(df_clean, columns=['category'], prefix='cat')

    # Separate features and target
    X = df_encoded.drop('target', axis=1)
    y = df_encoded['target']

    # Scale features
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    return X_scaled, y, scaler


def train_models(X, y):
    """Train XGBoost and LightGBM models."""
    # Split data
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # Train XGBoost
    print("\nTraining XGBoost...")
    xgb_model = xgb.XGBRegressor(n_estimators=100, max_depth=5, random_state=42)
    xgb_model.fit(X_train, y_train)
    xgb_score = xgb_model.score(X_test, y_test)
    print(f"XGBoost R² score: {xgb_score:.4f}")

    # Train LightGBM
    print("\nTraining LightGBM...")
    lgb_model = lgb.LGBMRegressor(n_estimators=100, max_depth=5, random_state=42)
    lgb_model.fit(X_train, y_train)
    lgb_score = lgb_model.score(X_test, y_test)
    print(f"LightGBM R² score: {lgb_score:.4f}")

    return xgb_model, lgb_model, X_test, y_test


def visualize_results(xgb_model, lgb_model, X_test, y_test):
    """Create visualization of model predictions."""
    xgb_pred = xgb_model.predict(X_test)
    lgb_pred = lgb_model.predict(X_test)

    fig, axes = plt.subplots(1, 2, figsize=(12, 5))

    # XGBoost predictions
    axes[0].scatter(y_test, xgb_pred, alpha=0.5)
    axes[0].plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()], 'r--', lw=2)
    axes[0].set_xlabel('Actual')
    axes[0].set_ylabel('Predicted')
    axes[0].set_title('XGBoost Predictions')

    # LightGBM predictions
    axes[1].scatter(y_test, lgb_pred, alpha=0.5)
    axes[1].plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()], 'r--', lw=2)
    axes[1].set_xlabel('Actual')
    axes[1].set_ylabel('Predicted')
    axes[1].set_title('LightGBM Predictions')

    plt.tight_layout()
    plt.savefig('model_comparison.png', dpi=150, bbox_inches='tight')
    print("\nVisualization saved to 'model_comparison.png'")


if __name__ == "__main__":
    print("Starting data pipeline...\n")

    # Load and clean data
    df = load_and_clean_data()

    # Preprocess
    X, y, scaler = preprocess_features(df)

    # Train models
    xgb_model, lgb_model, X_test, y_test = train_models(X, y)

    # Visualize
    visualize_results(xgb_model, lgb_model, X_test, y_test)

    print("\nPipeline complete!")

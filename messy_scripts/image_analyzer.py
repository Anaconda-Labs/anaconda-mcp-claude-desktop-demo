"""
Image Analysis Script - Found on GitHub
Author unknown, no environment specs included
"""

import cv2
import numpy as np
from sklearn.cluster import KMeans
from PIL import Image
import matplotlib.pyplot as plt
from skimage import filters, color


def analyze_image(image_path):
    """Analyze an image and extract dominant colors."""

    # Load image with OpenCV
    img_cv = cv2.imread(image_path)
    img_rgb = cv2.cvtColor(img_cv, cv2.COLOR_BGR2RGB)

    # Also load with PIL to show it works
    img_pil = Image.open(image_path)
    print(f"Image size: {img_pil.size}")

    # Convert to numpy array and reshape
    pixels = img_rgb.reshape(-1, 3)

    # Find dominant colors using K-means
    kmeans = KMeans(n_clusters=5, random_state=42, n_init=10)
    kmeans.fit(pixels)
    colors = kmeans.cluster_centers_

    print("Dominant colors (RGB):")
    for i, color_rgb in enumerate(colors):
        print(f"  Color {i+1}: {color_rgb.astype(int)}")

    # Apply edge detection
    gray = color.rgb2gray(img_rgb)
    edges = filters.sobel(gray)

    # Create visualization
    fig, axes = plt.subplots(1, 3, figsize=(15, 5))

    axes[0].imshow(img_rgb)
    axes[0].set_title('Original Image')
    axes[0].axis('off')

    axes[1].imshow(edges, cmap='gray')
    axes[1].set_title('Edge Detection')
    axes[1].axis('off')

    # Show color palette
    color_bar = np.zeros((50, 250, 3), dtype=np.uint8)
    for i, c in enumerate(colors):
        color_bar[:, i*50:(i+1)*50] = c
    axes[2].imshow(color_bar.astype(int))
    axes[2].set_title('Dominant Colors')
    axes[2].axis('off')

    plt.tight_layout()
    plt.savefig('analysis_result.png', dpi=150, bbox_inches='tight')
    print("\nAnalysis complete! Result saved to 'analysis_result.png'")

    return colors


if __name__ == "__main__":
    # Create a simple test image if none exists
    print("Creating test image...")
    test_img = np.random.randint(0, 255, (200, 300, 3), dtype=np.uint8)
    # Add some colored regions
    test_img[0:100, 0:150] = [255, 0, 0]    # Red
    test_img[0:100, 150:300] = [0, 0, 255]  # Blue
    test_img[100:200, 0:150] = [0, 255, 0]  # Green
    test_img[100:200, 150:300] = [255, 255, 0]  # Yellow

    Image.fromarray(test_img).save('test_image.png')
    print("Test image created: test_image.png")

    # Analyze the image
    analyze_image('test_image.png')

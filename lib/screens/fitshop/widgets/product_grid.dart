import 'package:flutter/material.dart';
import 'package:fitness_app_saas/models/product_model.dart';
import 'package:fitness_app_saas/screens/fitshop/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final String selectedCategory;
  final Function(Product) onAddToCart;
  final Function(Product) onToggleFavorite;

  const ProductGrid({
    Key? key,
    required this.products,
    required this.selectedCategory,
    required this.onAddToCart,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter products based on selected category
    final filteredProducts = selectedCategory == 'All'
        ? products
        : products
              .where((product) => product.category == selectedCategory)
              .toList();

    // Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive grid parameters
    int crossAxisCount;
    double childAspectRatio;
    double crossAxisSpacing;
    double mainAxisSpacing;

    if (screenWidth < 400) {
      // Small phones (e.g., iPhone SE)
      crossAxisCount = 1;
      childAspectRatio = 0.8;
      crossAxisSpacing = 8;
      mainAxisSpacing = 8;
    } else if (screenWidth < 600) {
      // Medium phones (e.g., iPhone 12)
      crossAxisCount = 2;
      childAspectRatio = 0.75;
      crossAxisSpacing = 10;
      mainAxisSpacing = 10;
    } else if (screenWidth < 900) {
      // Large phones/tablets (e.g., iPad mini)
      crossAxisCount = 2;
      childAspectRatio = 0.8;
      crossAxisSpacing = 12;
      mainAxisSpacing = 12;
    } else if (screenWidth < 1200) {
      // Tablets (e.g., iPad)
      crossAxisCount = 3;
      childAspectRatio = 0.85;
      crossAxisSpacing = 14;
      mainAxisSpacing = 14;
    } else {
      // Large tablets/desktops
      crossAxisCount = 4;
      childAspectRatio = 0.9;
      crossAxisSpacing = 16;
      mainAxisSpacing = 16;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return ProductCard(
            product: product,
            onAddToCart: () => onAddToCart(product),
            onToggleFavorite: onToggleFavorite,
          );
        },
      ),
    );
  }
}

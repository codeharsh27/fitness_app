import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:fitness_app_saas/models/product_model.dart';
import 'package:fitness_app_saas/screens/fitshop/product_detail_screen.dart';
import 'package:fitness_app_saas/services/favorites_service.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final Function(Product) onToggleFavorite;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onAddToCart,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ProductCard building for: ${product.name}');

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/product-detail', extra: product);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Get screen size for responsive design
          final screenWidth = MediaQuery.of(context).size.width;
          final isSmallScreen = screenWidth < 360;

          // Responsive dimensions
          final cardPadding = isSmallScreen ? 8.0 : 12.0;
          final borderRadius = isSmallScreen ? 12.0 : 16.0;
          final iconSize = isSmallScreen ? 32.0 : 40.0;
          final buttonSize = isSmallScreen ? 28.0 : 32.0;
          final badgeIconSize = isSmallScreen ? 14.0 : 16.0;

          // Responsive text sizes
          final brandFontSize = isSmallScreen ? 8.0 : 10.0;
          final productNameFontSize = isSmallScreen ? 12.0 : 14.0;
          final priceFontSize = isSmallScreen ? 14.0 : 16.0;
          final smallTextFontSize = isSmallScreen ? 8.0 : 10.0;

          // Responsive spacing
          final smallSpacing = isSmallScreen ? 1.0 : 2.0;
          final mediumSpacing = isSmallScreen ? 3.0 : 4.0;
          final largeSpacing = isSmallScreen ? 6.0 : 8.0;

          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: isSmallScreen ? 6.0 : 10.0,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image section
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(borderRadius),
                            topRight: Radius.circular(borderRadius),
                          ),
                          color: Colors.grey[800],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.fitness_center,
                            color: Colors.grey,
                            size: iconSize,
                          ),
                        ),
                      ),
                      // Discount badge
                      if (product.originalPrice != null)
                        Positioned(
                          top: isSmallScreen ? 6.0 : 8.0,
                          left: isSmallScreen ? 6.0 : 8.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 4.0 : 6.0,
                              vertical: isSmallScreen ? 1.0 : 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(
                                isSmallScreen ? 6.0 : 8.0,
                              ),
                            ),
                            child: Text(
                              '-${product.discountPercentage.toInt()}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: smallTextFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      // Favorite button
                      Positioned(
                        top: isSmallScreen ? 6.0 : 8.0,
                        right: isSmallScreen ? 6.0 : 8.0,
                        child: GestureDetector(
                          onTap: () {
                            print('Favorite button tapped for product: ${product.name}');
                            onToggleFavorite(product);
                          },
                          child: Container(
                            width: isSmallScreen ? 32.0 : 36.0,
                            height: isSmallScreen ? 32.0 : 36.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              GetIt.instance<FavoritesService>().isFavorite(product.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: GetIt.instance<FavoritesService>().isFavorite(product.id)
                                  ? Colors.red
                                  : Colors.grey[400],
                              size: badgeIconSize,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Product details section
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Brand
                        Text(
                          product.brand.toUpperCase(),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: brandFontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: smallSpacing),
                        // Product name
                        Expanded(
                          child: Text(
                            product.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: productNameFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: mediumSpacing),
                        // Rating
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...List.generate(5, (index) {
                              if (index < product.rating.floor()) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: smallTextFontSize + 2,
                                );
                              } else if (index == product.rating.floor() &&
                                  product.rating % 1 != 0) {
                                return Icon(
                                  Icons.star_half,
                                  color: Colors.amber,
                                  size: smallTextFontSize + 2,
                                );
                              } else {
                                return Icon(
                                  Icons.star_border,
                                  color: Colors.grey[600],
                                  size: smallTextFontSize + 2,
                                );
                              }
                            }),
                            SizedBox(width: mediumSpacing),
                            Text(
                              '(${product.reviewCount})',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: smallTextFontSize,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: largeSpacing),
                        // Price and button row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: priceFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (product.originalPrice != null)
                                    Text(
                                      '${product.originalPrice!.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: smallTextFontSize + 1,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(width: mediumSpacing),
                            // Add to cart button
                            Container(
                              width: buttonSize,
                              height: buttonSize,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(
                                  isSmallScreen ? 6.0 : 8.0,
                                ),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: onAddToCart,
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: isSmallScreen ? 14.0 : 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

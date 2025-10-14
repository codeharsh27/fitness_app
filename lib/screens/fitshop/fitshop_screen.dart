import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:fitness_app_saas/models/product_model.dart';
import 'package:fitness_app_saas/models/user_model.dart';
import 'package:fitness_app_saas/screens/fitshop/widgets/category_filters.dart';
import 'package:fitness_app_saas/screens/fitshop/widgets/product_grid.dart';
import 'package:fitness_app_saas/screens/fitshop/widgets/promotional_banners.dart';
import 'package:fitness_app_saas/services/favorites_service.dart';

class FitshopScreen extends StatefulWidget {
  final UserModel user;

  const FitshopScreen({Key? key, required this.user}) : super(key: key);

  @override
  _FitshopScreenState createState() => _FitshopScreenState();
}

class _FitshopScreenState extends State<FitshopScreen> {
  String selectedCategory = 'Proteins';
  int cartItemCount = 3;
  int favoriteItemCount = 0; // Will be calculated from products
  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();

  // Sample products data
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Gold Standard Whey',
      brand: 'Optimum Nutrition',
      price: 59.99,
      originalPrice: 69.99,
      rating: 4.5,
      reviewCount: 128,
      image: 'assets/images/gold_standard_whey.jpg',
      category: 'Proteins',
    ),
    Product(
      id: '2',
      name: 'C4 Pre-workout',
      brand: 'Cellucor',
      price: 32.99,
      originalPrice: 39.99,
      rating: 4.5,
      reviewCount: 95,
      image: 'assets/images/c4_preworkout.jpg',
      category: 'Pre-workout',
    ),
    Product(
      id: '3',
      name: 'Resistance Bands Set',
      brand: 'Fit Simplify',
      price: 24.99,
      originalPrice: 34.99,
      rating: 4.3,
      reviewCount: 256,
      image: 'assets/images/resistance_bands.jpg',
      category: 'Equipment',
    ),
    Product(
      id: '4',
      name: 'Creatine Monohydrate',
      brand: 'Optimum Nutrition',
      price: 19.99,
      originalPrice: 24.99,
      rating: 4.7,
      reviewCount: 89,
      image: 'assets/images/creatine.jpg',
      category: 'Supplements',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Removed real-time typing listener - only log submitted searches
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Method to close search when tapping outside
  void _closeSearch() {
    if (isSearchExpanded) {
      setState(() {
        isSearchExpanded = false;
        searchController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate favorite count from FavoritesService
    final favoritesService = GetIt.instance<FavoritesService>();
    favoriteItemCount = favoritesService.favoriteProducts.length;

    // Debug: Print current favorite status for all products
    for (var product in products) {
      print(
        'Product ${product.name}: isFavorite = ${favoritesService.isFavorite(product.id)}',
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            // Profile picture
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push('/profile', extra: widget.user);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[700],
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://play-lh.googleusercontent.com/FXz4tcGvAfErKrY1DXX_VxlA8hh4Nb_IEOJeLUZ3pAw4JCke2VEnfYHQ71WeWS7u6LM',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Spacer(),
            // Search functionality - expandable search bar
            if (!isSearchExpanded)
              IconButton(
                onPressed: () {
                  setState(() {
                    isSearchExpanded = true;
                  });
                },
                icon: const Icon(Icons.search, color: Colors.white),
              )
            else
              // Expanded search bar
              Expanded(
                flex: 2, // Increased flex to make search bar wider
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ), // Reduced margin
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isSearchExpanded = false;
                            searchController.clear();
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey[400],
                          size: 20,
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onSubmitted: (value) {
                      // Handle search functionality and log what user searched
                      print('User searched for: "$value"');
                      // Removed SnackBar to keep UI clean
                    },
                  ),
                ),
              ),
            const SizedBox(width: 5),
            // Favorite icon
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).push('/favorites');
                  },
                  icon: const Icon(Icons.favorite_border, color: Colors.white),
                ),
                if (favoriteItemCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        favoriteItemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 5),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).push('/cart');
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
                if (cartItemCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        cartItemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const PromotionalBanners(),
            const SizedBox(height: 20),
            CategoryFilters(
              selectedCategory: selectedCategory,
              onCategoryChanged: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
            const SizedBox(height: 20),
            ProductGrid(
              products: products,
              selectedCategory: selectedCategory,
              onAddToCart: (product) {
                setState(() {
                  cartItemCount++;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              onToggleFavorite: (product) {
                final favoritesService = GetIt.instance<FavoritesService>();
                print(
                  'Toggling favorite for product: ${product.name} (ID: ${product.id})',
                );
                favoritesService.toggleFavorite(product);
                print(
                  'Current favorite count: ${favoritesService.favoriteProducts.length}',
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

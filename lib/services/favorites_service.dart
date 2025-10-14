import 'package:flutter/foundation.dart';
import 'package:fitness_app_saas/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesService extends ChangeNotifier {
  List<Product> _favoriteProducts = [];
  static const String _favoritesKey = 'favorite_products';

  FavoritesService() {
    _clearAllFavorites(); // Start with empty favorites for testing
    _loadFavorites();
  }

  // Method to clear all favorites (for testing)
  void _clearAllFavorites() {
    _favoriteProducts.clear();
  }

  List<Product> get favoriteProducts => _favoriteProducts;

  bool isFavorite(String productId) {
    final result = _favoriteProducts.any((product) => product.id == productId);
    print('isFavorite($productId): $result');
    return result;
  }

  // Method to manually set favorite status (for testing)
  void setFavorite(Product product, bool isFavorite) {
    final existingIndex = _favoriteProducts.indexWhere((p) => p.id == product.id);

    if (isFavorite && existingIndex < 0) {
      // Add to favorites
      _favoriteProducts.add(product);
      print('Manually added ${product.name} to favorites');
    } else if (!isFavorite && existingIndex >= 0) {
      // Remove from favorites
      _favoriteProducts.removeAt(existingIndex);
      print('Manually removed ${product.name} from favorites');
    }

    notifyListeners();
  }

  Future<void> toggleFavorite(Product product) async {
    print('toggleFavorite called for: ${product.name} (ID: ${product.id})');
    print('Current favorites count: ${_favoriteProducts.length}');

    final existingIndex = _favoriteProducts.indexWhere((p) => p.id == product.id);
    print('Existing index: $existingIndex');

    if (existingIndex >= 0) {
      // Remove from favorites
      _favoriteProducts.removeAt(existingIndex);
      print('Removed ${product.name} from favorites');
    } else {
      // Add to favorites
      _favoriteProducts.add(product);
      print('Added ${product.name} to favorites');
    }

    print('New favorites count: ${_favoriteProducts.length}');

    // Save first, then notify listeners
    await _saveFavorites();

    // Notify listeners after saving
    notifyListeners();
    print('Notified listeners');
  }

  Future<void> removeFavorite(String productId) async {
    _favoriteProducts.removeWhere((product) => product.id == productId);
    notifyListeners();
    await _saveFavorites();
  }

  Future<void> clearAllFavorites() async {
    _favoriteProducts.clear();
    notifyListeners();
    await _saveFavorites();
  }

  // Private methods for persistence
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString(_favoritesKey);

      if (favoritesJson != null) {
        final List<dynamic> favoritesList = json.decode(favoritesJson);
        _favoriteProducts = favoritesList
            .map((item) => Product.fromMap(item as Map<String, dynamic>, item['id'] as String))
            .toList();
        print('Loaded ${_favoriteProducts.length} favorites from storage');
        notifyListeners();
      } else {
        print('No favorites found in storage');
      }
    } catch (e) {
      debugPrint('Error loading favorites: $e');
      print('Error details: $e');
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = json.encode(
        _favoriteProducts.map((product) => product.toMap()).toList(),
      );
      await prefs.setString(_favoritesKey, favoritesJson);
      print('Saved ${_favoriteProducts.length} favorites to storage');
    } catch (e) {
      debugPrint('Error saving favorites: $e');
      print('Error details: $e');
    }
  }
}

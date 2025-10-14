class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewCount;
  final String image;
  final String category;
  final bool? isNew;
  final String? description;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.image,
    required this.category,
    this.isNew,
    this.description,
    this.isFavorite = false,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      brand: map['brand'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      originalPrice: map['originalPrice']?.toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      isNew: map['isNew'] ?? false,
      description: map['description'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'originalPrice': originalPrice,
      'rating': rating,
      'reviewCount': reviewCount,
      'image': image,
      'category': category,
      'isNew': isNew,
      'description': description,
      'isFavorite': isFavorite,
    };
  }

  Product copyWith({bool? isFavorite}) {
    return Product(
      id: id,
      name: name,
      brand: brand,
      price: price,
      originalPrice: originalPrice,
      rating: rating,
      reviewCount: reviewCount,
      image: image,
      category: category,
      isNew: isNew,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  double get discountPercentage {
    if (originalPrice == null) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }
}

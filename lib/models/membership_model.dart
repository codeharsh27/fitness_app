class MembershipPlan {
  final String id;
  final String name;
  final String description;
  final double price;
  final int durationInDays;
  final List<String> features;
  final bool isPopular;
  final String badgeText;

  MembershipPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationInDays,
    required this.features,
    this.isPopular = false,
    this.badgeText = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'durationInDays': durationInDays,
      'features': features,
      'isPopular': isPopular,
      'badgeText': badgeText,
    };
  }

  factory MembershipPlan.fromMap(Map<String, dynamic> map) {
    return MembershipPlan(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      durationInDays: map['durationInDays'] ?? 30,
      features: List<String>.from(map['features'] ?? []),
      isPopular: map['isPopular'] ?? false,
      badgeText: map['badgeText'] ?? '',
    );
  }

  // Sample membership plans
  static List<MembershipPlan> samplePlans() {
    return [
      MembershipPlan(
        id: 'basic',
        name: 'Basic',
        description: 'Essential fitness features for beginners',
        price: 9.99,
        durationInDays: 30,
        features: [
          'Access to basic workout plans',
          'Diet recommendations',
          'Progress tracking',
          'Community access',
        ],
      ),
      MembershipPlan(
        id: 'premium',
        name: 'Premium',
        description: 'Advanced features for serious fitness enthusiasts',
        price: 19.99,
        durationInDays: 30,
        features: [
          'All Basic features',
          'Personalized workout plans',
          'Custom diet plans',
          'Weekly trainer consultation',
          'Priority support',
        ],
        isPopular: true,
        badgeText: 'POPULAR',
      ),
      MembershipPlan(
        id: 'elite',
        name: 'Elite',
        description: 'Ultimate fitness experience with personal coaching',
        price: 39.99,
        durationInDays: 30,
        features: [
          'All Premium features',
          'Unlimited trainer sessions',
          'Nutrition specialist consultation',
          'Personalized fitness journey',
          'Exclusive content access',
          '24/7 support',
        ],
      ),
    ];
  }
}

class UserMembership {
  final String planId;
  final String planName;
  final DateTime startDate;
  final DateTime expiryDate;
  final bool isActive;

  UserMembership({
    required this.planId,
    required this.planName,
    required this.startDate,
    required this.expiryDate,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'planId': planId,
      'planName': planName,
      'startDate': startDate,
      'expiryDate': expiryDate,
      'isActive': isActive,
    };
  }

  factory UserMembership.fromMap(Map<String, dynamic> map) {
    return UserMembership(
      planId: map['planId'] ?? '',
      planName: map['planName'] ?? '',
      startDate: map['startDate']?.toDate() ?? DateTime.now(),
      expiryDate: map['expiryDate']?.toDate() ?? DateTime.now(),
      isActive: map['isActive'] ?? false,
    );
  }

  int get daysRemaining {
    return expiryDate.difference(DateTime.now()).inDays;
  }

  bool get isExpired {
    return DateTime.now().isAfter(expiryDate);
  }
}

class PaymentHistory {
  final String id;
  final String planId;
  final String planName;
  final double amount;
  final DateTime timestamp;
  final String status;

  PaymentHistory({
    required this.id,
    required this.planId,
    required this.planName,
    required this.amount,
    required this.timestamp,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'planId': planId,
      'planName': planName,
      'amount': amount,
      'timestamp': timestamp,
      'status': status,
    };
  }

  factory PaymentHistory.fromMap(Map<String, dynamic> map) {
    return PaymentHistory(
      id: map['id'] ?? '',
      planId: map['planId'] ?? '',
      planName: map['planName'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      timestamp: map['timestamp']?.toDate() ?? DateTime.now(),
      status: map['status'] ?? 'pending',
    );
  }
}
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fitness_app_saas/services/firestore_service.dart';

class PaymentService {
  final Razorpay _razorpay = Razorpay();
  final FirestoreService _firestoreService = FirestoreService();
  
  // Initialize payment service
  void initialize({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onError,
    required Function(ExternalWalletResponse) onWalletSelected,
  }) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onWalletSelected);
  }
  
  // Clean up resources
  void dispose() {
    _razorpay.clear();
  }
  
  // Process payment
  void processPayment({
    required String userId,
    required String planId,
    required String planName,
    required double amount,
    required String currency,
    required String userEmail,
    required String userName,
    required String description,
  }) {
    final options = {
      'key': 'rzp_test_YOUR_KEY_HERE', // Replace with your Razorpay key
      'amount': (amount * 100).toInt(), // Amount in smallest currency unit (paise for INR)
      'name': 'FitSaaS',
      'description': description,
      'prefill': {
        'contact': '',
        'email': userEmail,
        'name': userName,
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }
  
  // Record successful payment in Firestore
  Future<void> recordPayment({
    required String userId,
    required String paymentId,
    required String planId,
    required String planName,
    required double amount,
    required int durationInDays,
  }) async {
    final now = DateTime.now();
    final expiryDate = now.add(Duration(days: durationInDays));
    
    // Create payment record
    await _firestoreService.addDocument('payments', {
      'userId': userId,
      'paymentId': paymentId,
      'planId': planId,
      'planName': planName,
      'amount': amount,
      'status': 'completed',
      'timestamp': now,
    });
    
    // Update user's membership status
    await _firestoreService.updateUserProfile(userId, {
      'membership': {
        'planId': planId,
        'planName': planName,
        'startDate': now,
        'expiryDate': expiryDate,
        'isActive': true,
      }
    });
  }
  
  // Check if user has active membership
  Future<bool> hasActiveMembership(String userId) async {
    final userData = await _firestoreService.getUserData(userId);
    
    if (userData != null && 
        userData['membership'] != null && 
        userData['membership']['isActive'] == true) {
      
      // Check if membership has expired
      final expiryDate = userData['membership']['expiryDate'].toDate();
      final now = DateTime.now();
      
      if (expiryDate.isAfter(now)) {
        return true;
      } else {
        // Membership has expired, update status
        await _firestoreService.updateUserProfile(userId, {
          'membership.isActive': false
        });
        return false;
      }
    }
    
    return false;
  }
  
  // Get membership details
  Future<Map<String, dynamic>?> getMembershipDetails(String userId) async {
    final userData = await _firestoreService.getUserData(userId);
    
    if (userData != null && userData['membership'] != null) {
      return userData['membership'];
    }
    
    return null;
  }
  
  // Get payment history
  Future<List<Map<String, dynamic>>> getPaymentHistory(String userId) async {
    final payments = await _firestoreService.getCollection(
      'payments',
      queryBuilder: (query) => query.where('userId', isEqualTo: userId).orderBy('timestamp', descending: true),
    );
    
    return payments;
  }
}
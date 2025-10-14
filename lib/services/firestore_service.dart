import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fitness_app_saas/models/user_model.dart';
import 'package:fitness_app_saas/services/firebase_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseService.firestore;

  // User Collection Reference
  CollectionReference get usersCollection => _firestore.collection('users');
  
  // Get user data
  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await usersCollection.doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user: $e');
      return null;
    }
  }

  // Get user data as map
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await usersCollection.doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user data: $e');
      return null;
    }
  }

  // Update user data
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await usersCollection.doc(uid).update(data);
    } catch (e) {
      debugPrint('Error updating user: $e');
      rethrow;
    }
  }

  // Update user profile data
  Future<void> updateUserProfile(String uid, Map<String, dynamic> profileData) async {
    try {
      await usersCollection.doc(uid).set({
        'profileData': profileData,
        'profileCompleted': true,
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error updating user profile: $e');
      rethrow;
    }
  }
  
  // Add document to a collection
  Future<DocumentReference> addDocument(String collection, Map<String, dynamic> data) async {
    try {
      return await _firestore.collection(collection).add(data);
    } catch (e) {
      debugPrint('Error adding document: $e');
      rethrow;
    }
  }
  
  // Get collection data with optional query
  Future<List<Map<String, dynamic>>> getCollection(
    String collection, {
    Function(Query)? queryBuilder,
  }) async {
    try {
      Query query = _firestore.collection(collection);
      
      if (queryBuilder != null) {
        query = queryBuilder(query);
      }
      
      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
          .toList();
    } catch (e) {
      debugPrint('Error getting collection: $e');
      return [];
    }
  }

  // Stream of user data
  Stream<UserModel?> userStream(String uid) {
    return usersCollection.doc(uid).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    });
  }
  
  // Admin dashboard methods
  Future<Map<String, dynamic>> getAdminDashboardStats() async {
    final usersSnapshot = await _firestore.collection('users').get();
    final membershipsSnapshot = await _firestore.collection('memberships').get();
    final paymentsSnapshot = await _firestore.collection('payments').get();
    
    int totalUsers = 0;
    int totalTrainers = 0;
    int activeSubscriptions = 0;
    double totalRevenue = 0;
    
    // Count users and trainers
    for (var doc in usersSnapshot.docs) {
      final userData = doc.data();
      if (userData['role'] == 'trainer') {
        totalTrainers++;
      } else if (userData['role'] == 'user') {
        totalUsers++;
      }
    }
    
    // Count active subscriptions
    final now = DateTime.now();
    for (var doc in membershipsSnapshot.docs) {
      final membershipData = doc.data();
      final expiryDate = (membershipData['expiryDate'] as Timestamp).toDate();
      if (expiryDate.isAfter(now)) {
        activeSubscriptions++;
      }
    }
    
    // Calculate total revenue
    for (var doc in paymentsSnapshot.docs) {
      final paymentData = doc.data();
      totalRevenue += (paymentData['amount'] as num).toDouble();
    }
    
    return {
      'totalUsers': totalUsers,
      'totalTrainers': totalTrainers,
      'activeSubscriptions': activeSubscriptions,
      'totalRevenue': totalRevenue,
    };
  }
  
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'user')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
  
  Stream<List<Map<String, dynamic>>> getTrainersStream() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'trainer')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
  
  Stream<List<Map<String, dynamic>>> getMembershipsStream() {
    return _firestore
        .collection('memberships')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
  
  Future<void> deleteUser(String uid) async {
    // Delete user document
    await _firestore.collection('users').doc(uid).delete();
    
    // Delete related data (memberships, payments, etc.)
    final memberships = await _firestore
        .collection('memberships')
        .where('userId', isEqualTo: uid)
        .get();
    
    for (var doc in memberships.docs) {
      await doc.reference.delete();
    }
    
    final payments = await _firestore
        .collection('payments')
        .where('userId', isEqualTo: uid)
        .get();
    
    for (var doc in payments.docs) {
      await doc.reference.delete();
    }
  }
}
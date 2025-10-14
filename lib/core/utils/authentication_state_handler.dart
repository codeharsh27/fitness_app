import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_saas/services/auth_service.dart';
import 'package:fitness_app_saas/services/firestore_service.dart';
import 'package:fitness_app_saas/models/user_model.dart';

class AuthenticationStateHandler extends StatefulWidget {
  const AuthenticationStateHandler({Key? key}) : super(key: key);

  @override
  _AuthenticationStateHandlerState createState() => _AuthenticationStateHandlerState();
}

class _AuthenticationStateHandlerState extends State<AuthenticationStateHandler> {
  // Cache user data to avoid repeated Firestore calls
  UserModel? _cachedUserModel;

  @override
  Widget build(BuildContext context) {
    final authService = GetIt.instance<AuthService>();
    final firestoreService = GetIt.instance<FirestoreService>();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // Handle auth state stream errors
        if (snapshot.hasError) {
          debugPrint('Auth state error: ${snapshot.error}');
          return _buildErrorScreen('Authentication Error', 'Failed to check authentication state');
        }

        // Show loading immediately while checking auth state
        if (!snapshot.hasData) {
          return _buildFastLoadingScreen('Checking authentication...');
        }

        final firebaseUser = snapshot.data;

        if (firebaseUser != null) {
          // Check cache first to avoid Firestore call
          if (_cachedUserModel != null && _cachedUserModel!.uid == firebaseUser.uid) {
            return _handleUserNavigation(context, _cachedUserModel!);
          }

          // Start loading user data immediately when we have a user
          return FutureBuilder<UserModel?>(
            future: firestoreService.getUser(firebaseUser.uid),
            builder: (context, userSnapshot) {
              // Handle Firestore errors
              if (userSnapshot.hasError) {
                debugPrint('Firestore error: ${userSnapshot.error}');
                return _buildErrorScreen('Data Error', 'Failed to load user data');
              }

              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return _buildFastLoadingScreen('Loading your profile...');
              }

              if (userSnapshot.hasData && userSnapshot.data != null) {
                final userModel = userSnapshot.data!;
                // Cache the user data
                _cachedUserModel = userModel;

                debugPrint(
                  'User data loaded: ${userModel.email}, profileCompleted: ${userModel.profileCompleted}',
                );

                return _handleUserNavigation(context, userModel);
              }

              // User exists in Firebase Auth but not in Firestore
              debugPrint('User not found in Firestore, redirecting to onboarding');
              GoRouter.of(context).go('/onboarding');
              return _buildFastLoadingScreen('First time setup...');
            },
          );
        }

        debugPrint('User is not signed in, showing login screen');
        // Clear cache when user logs out
        _cachedUserModel = null;
        // Navigate immediately for unauthenticated users
        GoRouter.of(context).go('/login');
        return _buildFastLoadingScreen('Redirecting to login...');
      },
    );
  }

  Widget _handleUserNavigation(BuildContext context, UserModel userModel) {
    // Navigate immediately without post frame callback delay
    if (!userModel.profileCompleted) {
      debugPrint('Redirecting to onboarding - profile not completed');
      GoRouter.of(context).go('/onboarding');
      return _buildFastLoadingScreen('Setting up your profile...');
    }

    debugPrint('Redirecting to dashboard - profile completed');
    GoRouter.of(context).go('/dashboard', extra: userModel);
    return _buildFastLoadingScreen('Welcome back!');
  }

  Widget _buildFastLoadingScreen(String message) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 24),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorScreen(String title, String message) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[300],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Force rebuild to retry
                  setState(() {});
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

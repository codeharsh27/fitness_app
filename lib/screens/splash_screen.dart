import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:fitness_app_saas/services/auth_service.dart';
import 'package:fitness_app_saas/services/firestore_service.dart';
import 'package:fitness_app_saas/models/user_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Logo scale animation (simplified)
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800), // Reduced duration
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut), // Simpler curve
    );

    // Fade animation for text (simplified)
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600), // Reduced duration
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn), // Simpler curve
    );

    // Start animations
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _fadeController.forward();
    });

    // Navigate after 2 seconds (reduced from 3)
    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;

      try {
        // Check authentication state using GetIt
        final authService = GetIt.instance<AuthService>();
        final firestoreService = GetIt.instance<FirestoreService>();

        final firebaseUser = authService.currentUser;

        if (firebaseUser != null) {
          // User is signed in, check onboarding status
          final prefs = await SharedPreferences.getInstance();
          final hasCompletedOnboarding =
              prefs.getBool('hasCompletedOnboarding') ?? false;

          if (hasCompletedOnboarding) {
            // Check if profile is complete in Firestore (async, don't await)
            firestoreService.getUser(firebaseUser.uid).then((userModel) {
              if (userModel != null && userModel.profileCompleted && mounted) {
                GoRouter.of(context).go('/dashboard', extra: userModel);
              } else if (mounted) {
                GoRouter.of(context).go('/onboarding');
              }
            }).catchError((_) {
              if (mounted) GoRouter.of(context).go('/onboarding');
            });
          } else {
            if (mounted) GoRouter.of(context).go('/onboarding');
          }
        } else {
          if (mounted) GoRouter.of(context).go('/login');
        }
      } catch (e) {
        if (mounted) GoRouter.of(context).go('/login');
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Colors.grey[900]!, Colors.black],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // App Name
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'ORACLE FITNESS',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 3,
                      shadows: [
                        Shadow(
                          color: Colors.red.shade800.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Tagline
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Your Journey to Strength Begins',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                      letterSpacing: 1,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                // Loading indicator
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

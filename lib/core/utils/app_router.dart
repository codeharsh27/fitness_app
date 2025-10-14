import 'package:go_router/go_router.dart';
import 'package:fitness_app_saas/screens/auth/login_screen.dart';
import 'package:fitness_app_saas/screens/auth/register_screen.dart';
import 'package:fitness_app_saas/screens/auth/forgot_password_screen.dart';
import 'package:fitness_app_saas/screens/onboarding/onboarding_screen.dart';
import 'package:fitness_app_saas/screens/dashboard/dashboard_screen.dart';
import 'package:fitness_app_saas/screens/dashboard/profile_screen.dart';
import 'package:fitness_app_saas/screens/fitshop/favorites_page.dart';
import 'package:fitness_app_saas/screens/fitshop/cart_checkout_page.dart';
import 'package:fitness_app_saas/screens/fitshop/product_detail_screen.dart';
import 'package:fitness_app_saas/screens/splash_screen.dart';
import 'package:fitness_app_saas/models/user_model.dart';
import 'package:fitness_app_saas/models/product_model.dart';

// GoRouter configuration
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) {
        final user = state.extra as UserModel?;
        if (user == null) {
          // Redirect to login if no user provided
          return const LoginScreen();
        }
        return DashboardScreen(user: user);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        final user = state.extra as UserModel?;
        if (user == null) {
          return const LoginScreen();
        }
        return ProfileScreen(user: user);
      },
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
    GoRoute(
      path: '/product-detail',
      builder: (context, state) {
        final product = state.extra as Product?;
        if (product == null) {
          return const LoginScreen();
        }
        return ProductDetailScreen(product: product);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartCheckoutPage(),
    ),
  ],
);

import 'package:get_it/get_it.dart';
import 'package:fitness_app_saas/services/auth_service.dart';
import 'package:fitness_app_saas/services/firestore_service.dart';
import 'package:fitness_app_saas/services/favorites_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  try {
    // Register services as singletons
    getIt.registerSingleton<AuthService>(AuthService());
    getIt.registerSingleton<FirestoreService>(FirestoreService());
    getIt.registerSingleton<FavoritesService>(FavoritesService());
  } catch (e) {
    // Log the error and rethrow - the app should handle this at startup
    print('Error setting up dependency injection: $e');
    rethrow;
  }
}

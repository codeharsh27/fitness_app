import 'package:flutter/material.dart';
import 'package:fitness_app_saas/models/user_model.dart';
import 'package:fitness_app_saas/screens/dashboard/home_screen.dart';
import 'package:fitness_app_saas/screens/workout/main_workout/workout_screen.dart';
import 'package:fitness_app_saas/screens/diet/diet_screen.dart';
import 'package:fitness_app_saas/screens/fitshop/fitshop_screen.dart';

class DashboardScreen extends StatefulWidget {
  final UserModel user;

  const DashboardScreen({Key? key, required this.user}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(user: widget.user),
      WorkoutScreen(user: widget.user),
      DietScreen(user: widget.user),
      FitshopScreen(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.red[800],
        unselectedItemColor: Colors.grey[400],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 24,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard, color: Colors.red[800]),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            activeIcon: Icon(Icons.fitness_center, color: Colors.red[800]),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_outlined),
            activeIcon: Icon(Icons.restaurant, color: Colors.red[800]),
            label: 'Diet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag, color: Colors.red[800]),
            label: 'Fitshop',
          ),
        ],
      ),
    );
  }
}

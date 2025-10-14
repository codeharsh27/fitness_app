import 'package:flutter/material.dart';
import 'package:fitness_app_saas/models/user_model.dart';
import 'package:fitness_app_saas/screens/diet/widgets/progress_chart.dart';
import 'package:fitness_app_saas/screens/diet/widgets/meal_card.dart';
import 'package:fitness_app_saas/screens/diet/widgets/meal_filter_chips.dart';
import 'package:fitness_app_saas/screens/diet/widgets/consultation_card.dart';

class DietScreen extends StatefulWidget {
  final UserModel user;

  const DietScreen({Key? key, required this.user}) : super(key: key);

  @override
  _DietScreenState createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  String selectedFilter = 'Vegetarian';

  // Sample data for the progress chart
  final List<double> weeklyProgress = [
    1200,
    1350,
    1100,
    1450,
    1300,
    1500,
    1400,
  ];
  final List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  // Sample meal data
  final List<MealData> meals = [
    MealData(
      type: 'Breakfast',
      name: 'Berry Oatmeal Bowl',
      calories: 320,
      protein: 12,
      image: 'assets/images/oatmeal.jpg',
      tags: ['Fiber-rich', 'Protein'],
      tagColors: [Colors.blue, Colors.green],
    ),
    MealData(
      type: 'Lunch',
      name: 'Quinoa Buddha Bowl',
      calories: 450,
      protein: 18,
      image: 'assets/images/quinoa.jpg',
      tags: ['High-protein', 'Balanced'],
      tagColors: [Colors.purple, Colors.amber],
      progress: '19/20',
    ),
    MealData(
      type: 'Dinner',
      name: 'Grilled Salmon & Vegetables',
      calories: 380,
      protein: 25,
      image: 'assets/images/salmon.jpg',
      tags: ['High-protein', 'Low-carb'],
      tagColors: [Colors.purple, Colors.orange],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildProgressSection(),
              const SizedBox(height: 24),
              MealFilterChips(
                selectedFilter: selectedFilter,
                onFilterChanged: (filter) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
              ),
              const SizedBox(height: 24),
              _buildMealsSection(),
              const ConsultationCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, ${widget.user.name}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Vegetarian • Weight Gain Goal',
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_fire_department,
                color: Colors.orange[400],
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                "Today's Progress",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ProgressChart(data: weeklyProgress, labels: weekDays),
          ),
        ],
      ),
    );
  }

  Widget _buildMealsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: meals.map((meal) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: MealCard(meal: meal),
        );
      }).toList(),
    );
  }
}

// Meal data model
class MealData {
  final String type;
  final String name;
  final int calories;
  final int protein;
  final String image;
  final List<String> tags;
  final List<Color> tagColors;
  final String? progress;

  MealData({
    required this.type,
    required this.name,
    required this.calories,
    required this.protein,
    required this.image,
    required this.tags,
    required this.tagColors,
    this.progress,
  });
}

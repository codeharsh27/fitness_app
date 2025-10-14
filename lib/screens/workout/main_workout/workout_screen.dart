import 'dart:async';
import 'package:fitness_app_saas/screens/dashboard/profile_screen.dart';
import 'package:fitness_app_saas/screens/workout/popular_workout/popular_workout_detail_screen.dart';
import 'package:fitness_app_saas/screens/workout/trainer_booking/trainer_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_saas/models/user_model.dart';
import 'package:fitness_app_saas/screens/workout/program_workout/program_detail_screen.dart';

class WorkoutScreen extends StatefulWidget {
  final UserModel user;

  const WorkoutScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  late ScrollController _popularWorkoutScrollController;
  late Timer _autoScrollTimer;
  late Timer _popularWorkoutAutoScrollTimer;
  int _currentCardIndex = 0;
  int _currentPopularWorkoutIndex = 0;
  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _popularWorkoutScrollController = ScrollController();

    // Start auto-scroll timers
    _startAutoScroll();
    _startPopularWorkoutAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        _scrollToNextCard();
      }
    });
  }

  void _startPopularWorkoutAutoScroll() {
    _popularWorkoutAutoScrollTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (mounted) {
          _scrollToNextPopularWorkout();
        }
      },
    );
  }

  void _scrollToNextCard() {
    setState(() {
      _currentCardIndex = (_currentCardIndex + 1) % 4; // 4 cards total
    });

    // Calculate scroll position for the current card
    double scrollPosition = _currentCardIndex * 232; // 220 width + 12 margin

    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToNextPopularWorkout() {
    setState(() {
      _currentPopularWorkoutIndex =
          (_currentPopularWorkoutIndex + 1) % 4; // 4 cards total
    });

    // Calculate scroll position for popular workout cards
    double scrollPosition =
        _currentPopularWorkoutIndex * 312; // 300 width + 12 margin

    _popularWorkoutScrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  // Method to close search when tapping outside
  void _closeSearch() {
    if (isSearchExpanded) {
      setState(() {
        isSearchExpanded = false;
        searchController.clear();
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _popularWorkoutScrollController.dispose();
    _autoScrollTimer.cancel();
    _popularWorkoutAutoScrollTimer.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: widget.user),
                ),
              );
            },
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.red.shade100,
              backgroundImage: NetworkImage(
                'https://play-lh.googleusercontent.com/FXz4tcGvAfErKrY1DXX_VxlA8hh4Nb_IEOJeLUZ3pAw4JCke2VEnfYHQ71WeWS7u6LM',
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Workout',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        actions: [
          // Search functionality - expandable search bar
          if (!isSearchExpanded)
            IconButton(
              onPressed: () {
                setState(() {
                  isSearchExpanded = true;
                });
              },
              icon: const Icon(Icons.search, color: Colors.white),
            )
          else
            // Expanded search bar
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:
                    250, // Limit maximum width to prevent covering whole app bar
                minWidth: 200, // Ensure minimum usable width
              ),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search workouts...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isSearchExpanded = false;
                          searchController.clear();
                        });
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (value) {
                    // Handle search functionality and log what user searched
                    print('User searched for: "$value"');
                    // Removed SnackBar to keep UI clean
                  },
                ),
              ),
            ),
          const SizedBox(width: 10),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade400,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Discover'),
            Tab(text: 'My Plans'),
            Tab(text: 'Progress'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDiscoverTab(),
          _buildMyPlansTab(),
          _buildProgressTab(),
        ],
      ),
    );
  }

  Widget _buildMyPlansTab() {
    // Sample workout plans
    final workoutPlans = [
      {
        'name': 'Weight Loss Program',
        'description': '12-week program designed for weight loss',
        'progress': 0.4,
        'color': Colors.orange,
        'icon': Icons.trending_down,
      },
      {
        'name': 'Muscle Building',
        'description': '8-week strength training program',
        'progress': 0.7,
        'color': Colors.green,
        'icon': Icons.fitness_center,
      },
      {
        'name': 'Flexibility & Mobility',
        'description': '4-week program to improve flexibility',
        'progress': 0.2,
        'color': Colors.purple,
        'icon': Icons.self_improvement,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workoutPlans.length,
      itemBuilder: (context, index) {
        final plan = workoutPlans[index];
        return _buildWorkoutPlanCard(
          name: plan['name'] as String,
          description: plan['description'] as String,
          progress: plan['progress'] as double,
          color: plan['color'] as Color,
          icon: plan['icon'] as IconData,
        );
      },
    );
  }

  Widget _buildDiscoverTab() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Programs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 340,
              child: ListView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                children: [
                  _buildProgramCard(
                    'Push, Pull, Leg',
                    '3x3 days split program',
                    Icons.trending_down,
                    Colors.orange,
                    'workout1',
                  ),
                  _buildProgramCard(
                    'Bro-Split Hybrid',
                    'Old-School Muscle Building with a Strategic Upgrade',
                    Icons.fitness_center,
                    Colors.green,
                    'workout2',
                  ),
                  _buildProgramCard(
                    '5-Day Hybrid Athlete Plan',
                    'Where Strength Meets Aesthetics in a Smart Weekly Split',
                    Icons.directions_run,
                    Colors.blue,
                    'workout3',
                  ),
                  _buildProgramCard(
                    'PPL + Dedicated Arm Day',
                    'Targeted Volume for Full-Body Growth and Arm Specialization',
                    Icons.self_improvement,
                    Colors.purple,
                    'workout4',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Popular workout section
            const Text(
              'Popular workout',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                controller: _popularWorkoutScrollController,
                children: [
                  _buildPopularWorkoutCard(
                    imageName: 'workout1',
                    title: 'Back Attack',
                    level: 'Intermediate',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PopularWorkoutDetailScreen(
                          title: 'Back Attack',
                          subtitle: 'Build a strong, powerful back',
                          level: 'Intermediate',
                          imageName: 'workout1',
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  _buildPopularWorkoutCard(
                    imageName: 'workout2',
                    title: 'Chest Attack',
                    level: 'Advance',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PopularWorkoutDetailScreen(
                          title: 'Chest Attack',
                          subtitle: 'Sculpt your chest muscles',
                          level: 'Advance',
                          imageName: 'workout2',
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  _buildPopularWorkoutCard(
                    imageName: 'workout3',
                    title: 'Arms workout',
                    level: 'Intermediate',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PopularWorkoutDetailScreen(
                          title: 'Arms workout',
                          subtitle: 'Tone and strengthen your arms',
                          level: 'Intermediate',
                          imageName: 'workout3',
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  _buildPopularWorkoutCard(
                    imageName: 'workout4',
                    title: 'Legs Destroyer',
                    level: 'Advance',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PopularWorkoutDetailScreen(
                          title: 'Legs Destroyer',
                          subtitle: 'Intense leg day workout',
                          level: 'Advance',
                          imageName: 'workout4',
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Our Special Program section
            const Text(
              'Our Special Program',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/workout3.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Background overlay for better text readability
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Training label
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'Training',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        // Title
                        const Text(
                          'Muscle Building Workout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Subtitle
                        Text(
                          'Intense muscle building workout by expert',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Divider
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        const SizedBox(height: 5),
                        // Coach info row
                        Row(
                          children: [
                            // Coach avatar
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: const NetworkImage(
                                'https://manmaker.in/cdn/shop/articles/cbum-31-07-2024-0001.jpg?v=1722450546',
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Coach name
                            const Text(
                              'Coach Cbum',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            // Start button
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TrainerBookingScreen(
                                      trainerName: 'Coach Cbum',
                                      trainerImage:
                                          'https://manmaker.in/cdn/shop/articles/cbum-31-07-2024-0001.jpg?v=1722450546',
                                      trainerSpecialty:
                                          'Professional Bodybuilder & Trainer',
                                      experience: '10+ years experience',
                                      rating: '4.9',
                                      color: Colors.red.shade800,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade800,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Start',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Second Special Program section
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/workout4.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Background overlay for better text readability
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Training label
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'Training',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        // Title
                        const Text(
                          'Muscle Building Workout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Subtitle
                        Text(
                          'Intense muscle building workout by expert',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Divider
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        const SizedBox(height: 5),
                        // Coach info row
                        Row(
                          children: [
                            // Coach avatar
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: const NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg4EBXLI-mkizOWDiRf2bVt3G7QHzpEjVXnQ&s',
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Coach name
                            const Text(
                              'Saket',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            // Start button
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TrainerBookingScreen(
                                      trainerName: 'Saket',
                                      trainerImage:
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg4EBXLI-mkizOWDiRf2bVt3G7QHzpEjVXnQ&s',
                                      trainerSpecialty:
                                          'Fitness Coach & Nutritionist',
                                      experience: '8+ years experience',
                                      rating: '4.8',
                                      color: Colors.red.shade800,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade800,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Start',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularWorkoutCard({
    String? imageName,
    required String title,
    required String level,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 180,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage('assets/images/${imageName ?? 'workout1'}.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Favorite icon in top right
            Positioned(
              top: 12,
              right: 12,
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                radius: 16,
                child: const Icon(Icons.favorite, color: Colors.red, size: 16),
              ),
            ),
            // Workout title and level at bottom
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      level,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weekly summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.red.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Weekly Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProgressStat('Workouts', '4', '7'),
                    _buildProgressStat('Calories', '1,200', '3,500'),
                    _buildProgressStat('Minutes', '120', '210'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Recent activities
          const Text(
            'Recent Activities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildActivityItem(
                  date: 'Today',
                  name: 'Upper Body Strength',
                  duration: '45 min',
                  calories: '320',
                ),
                _buildActivityItem(
                  date: 'Yesterday',
                  name: 'HIIT Cardio',
                  duration: '30 min',
                  calories: '280',
                ),
                _buildActivityItem(
                  date: '2 days ago',
                  name: 'Core Workout',
                  duration: '20 min',
                  calories: '150',
                ),
                _buildActivityItem(
                  date: '3 days ago',
                  name: 'Leg Day',
                  duration: '50 min',
                  calories: '400',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutPlanCard({
    required String name,
    required String description,
    required double progress,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress: ${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to workout details
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Continue'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgramCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String imageName,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProgramDetailScreen(
              title: title,
              subtitle: subtitle,
              icon: icon,
              color: color,
              imageName: imageName,
            ),
          ),
        );
      },
      child: Container(
        width: 220,
        height: 340,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage('assets/images/$imageName.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
                Colors.black.withOpacity(0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 32),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgramDetailScreen(
                          title: title,
                          subtitle: subtitle,
                          icon: icon,
                          color: color,
                          imageName: imageName,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                  ),
                  child: const Text(
                    'Start Now',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStat(String label, String value, String total) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$label / $total',
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required String date,
    required String name,
    required String duration,
    required String calories,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.fitness_center, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                duration,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$calories cal',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

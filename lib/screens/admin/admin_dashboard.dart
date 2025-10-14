import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app_saas/services/auth_service.dart';
import 'package:fitness_app_saas/services/firestore_service.dart';
import 'package:fitness_app_saas/models/user_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  
  // Dashboard stats
  int _totalUsers = 0;
  int _totalTrainers = 0;
  int _activeSubscriptions = 0;
  double _totalRevenue = 0;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadDashboardData();
  }
  
  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final firestoreService = Provider.of<FirestoreService>(context, listen: false);
      
      // Get dashboard stats
      final stats = await firestoreService.getAdminDashboardStats();
      
      setState(() {
        _totalUsers = stats['totalUsers'] ?? 0;
        _totalTrainers = stats['totalTrainers'] ?? 0;
        _activeSubscriptions = stats['activeSubscriptions'] ?? 0;
        _totalRevenue = (stats['totalRevenue'] ?? 0).toDouble();
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading dashboard data: ${e.toString()}');
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Users'),
            Tab(text: 'Trainers'),
            Tab(text: 'Memberships'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildUsersTab(),
                _buildTrainersTab(),
                _buildMembershipsTab(),
              ],
            ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard Overview',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildStatsGrid(),
          const SizedBox(height: 24),
          _buildRecentActivitySection(),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          title: 'Total Users',
          value: _totalUsers.toString(),
          icon: Icons.people,
          color: Colors.blue,
        ),
        _buildStatCard(
          title: 'Total Trainers',
          value: _totalTrainers.toString(),
          icon: Icons.fitness_center,
          color: Colors.green,
        ),
        _buildStatCard(
          title: 'Active Subscriptions',
          value: _activeSubscriptions.toString(),
          icon: Icons.card_membership,
          color: Colors.orange,
        ),
        _buildStatCard(
          title: 'Total Revenue',
          value: '\$${_totalRevenue.toStringAsFixed(2)}',
          icon: Icons.attach_money,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return _buildActivityItem(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(int index) {
    final activities = [
      {
        'type': 'new_user',
        'title': 'New User Registration',
        'description': 'John Doe registered as a new user',
        'time': '10 minutes ago',
      },
      {
        'type': 'payment',
        'title': 'New Payment',
        'description': 'Sarah Smith purchased Premium Plan',
        'time': '1 hour ago',
      },
      {
        'type': 'trainer',
        'title': 'New Trainer',
        'description': 'Mike Johnson registered as a trainer',
        'time': '3 hours ago',
      },
      {
        'type': 'session',
        'title': 'Session Booked',
        'description': 'Emma Wilson booked a session with David Brown',
        'time': '5 hours ago',
      },
      {
        'type': 'feedback',
        'title': 'New Feedback',
        'description': 'Alex Taylor left a 5-star review',
        'time': '1 day ago',
      },
    ];
    
    final activity = activities[index];
    
    IconData icon;
    Color color;
    
    switch (activity['type']) {
      case 'new_user':
        icon = Icons.person_add;
        color = Colors.blue;
        break;
      case 'payment':
        icon = Icons.payment;
        color = Colors.green;
        break;
      case 'trainer':
        icon = Icons.fitness_center;
        color = Colors.orange;
        break;
      case 'session':
        icon = Icons.calendar_today;
        color = Colors.purple;
        break;
      case 'feedback':
        icon = Icons.star;
        color = Colors.amber;
        break;
      default:
        icon = Icons.info;
        color = Colors.grey;
    }
    
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
      title: Text(activity['title']!),
      subtitle: Text(activity['description']!),
      trailing: Text(
        activity['time']!,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildUsersTab() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: Provider.of<FirestoreService>(context).getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        
        final users = snapshot.data ?? [];
        
        if (users.isEmpty) {
          return const Center(child: Text('No users found'));
        }
        
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  // Implement search functionality
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final userModel = UserModel.fromMap(user, user['uid'] ?? '');
                  
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: userModel.photoUrl != null && userModel.photoUrl!.isNotEmpty
                            ? NetworkImage(userModel.photoUrl!)
                            : null,
                        child: userModel.photoUrl == null || userModel.photoUrl!.isEmpty
                            ? Text(userModel.name.isNotEmpty ? userModel.name[0].toUpperCase() : '?')
                            : null,
                      ),
                      title: Text(userModel.name),
                      subtitle: Text(userModel.email),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'view',
                            child: Text('View Profile'),
                          ),
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit User'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete User'),
                          ),
                        ],
                        onSelected: (value) {
                          // Handle menu item selection
                          switch (value) {
                            case 'view':
                              // Navigate to user profile
                              break;
                            case 'edit':
                              // Navigate to edit user screen
                              break;
                            case 'delete':
                              // Show delete confirmation dialog
                              _showDeleteConfirmationDialog(userModel);
                              break;
                          }
                        },
                      ),
                      onTap: () {
                        // Navigate to user details screen
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrainersTab() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: Provider.of<FirestoreService>(context).getTrainersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        
        final trainers = snapshot.data ?? [];
        
        if (trainers.isEmpty) {
          return const Center(child: Text('No trainers found'));
        }
        
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search trainers...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  // Implement search functionality
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: trainers.length,
                itemBuilder: (context, index) {
                  final trainer = trainers[index];
                  final trainerModel = UserModel.fromMap(trainer, trainer['uid'] ?? '');
                  
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundImage: trainerModel.photoUrl != null && trainerModel.photoUrl!.isNotEmpty
                            ? NetworkImage(trainerModel.photoUrl!)
                            : null,
                        child: trainerModel.photoUrl == null || trainerModel.photoUrl!.isEmpty
                            ? Text(trainerModel.name.isNotEmpty ? trainerModel.name[0].toUpperCase() : '?')
                            : null,
                      ),
                      title: Text(trainerModel.name),
                      subtitle: Text(trainerModel.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Active',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.expand_more),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Trainer Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildTrainerDetailItem('Specialization', trainer['profileData']?['specialization'] ?? 'Not specified'),
                              _buildTrainerDetailItem('Experience', '${trainer['profileData']?['experience'] ?? 'Not specified'} years'),
                              _buildTrainerDetailItem('Rating', '${trainer['profileData']?['rating'] ?? 'N/A'}/5'),
                              _buildTrainerDetailItem('Sessions Completed', trainer['profileData']?['sessionsCompleted']?.toString() ?? '0'),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      // Navigate to edit trainer screen
                                    },
                                    child: const Text('Edit'),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Navigate to trainer details screen
                                    },
                                    child: const Text('View Profile'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrainerDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipsTab() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: Provider.of<FirestoreService>(context).getMembershipsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        
        final memberships = snapshot.data ?? [];
        
        if (memberships.isEmpty) {
          return const Center(child: Text('No memberships found'));
        }
        
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search memberships...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        // Implement search functionality
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  PopupMenuButton(
                    icon: const Icon(Icons.filter_list),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'all',
                        child: Text('All'),
                      ),
                      const PopupMenuItem(
                        value: 'active',
                        child: Text('Active'),
                      ),
                      const PopupMenuItem(
                        value: 'expired',
                        child: Text('Expired'),
                      ),
                    ],
                    onSelected: (value) {
                      // Implement filter functionality
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: memberships.length,
                itemBuilder: (context, index) {
                  final membership = memberships[index];
                  final startDate = membership['startDate'] != null
                      ? (membership['startDate'] as dynamic).toDate()

                      : DateTime.now();
                  final expiryDate = membership['expiryDate'] != null
                      ? (membership['expiryDate'] as dynamic).toDate()
                      : DateTime.now();
                  final isExpired = expiryDate.isBefore(DateTime.now());
                  
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                membership['userName'] ?? 'Unknown User',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isExpired ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  isExpired ? 'Expired' : 'Active',
                                  style: TextStyle(
                                    color: isExpired ? Colors.red.shade700 : Colors.green.shade700,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            membership['planName'] ?? 'Unknown Plan',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildMembershipDetailItem(
                                'Start Date',
                                DateFormat('MMM dd, yyyy').format(startDate),
                              ),
                              _buildMembershipDetailItem(
                                'Expiry Date',
                                DateFormat('MMM dd, yyyy').format(expiryDate),
                              ),
                              _buildMembershipDetailItem(
                                'Amount',
                                '\$${membership['amount']?.toStringAsFixed(2) ?? '0.00'}',
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  // Show membership details
                                },
                                child: const Text('View Details'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: isExpired ? () {
                                  // Renew membership
                                } : null,
                                child: const Text('Renew'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMembershipDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              
              try {
                final firestoreService = Provider.of<FirestoreService>(context, listen: false);
                await firestoreService.deleteUser(user.uid);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User deleted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error deleting user: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ManageSubscriptionPage extends StatefulWidget {
  const ManageSubscriptionPage({Key? key}) : super(key: key);

  @override
  _ManageSubscriptionPageState createState() => _ManageSubscriptionPageState();
}

class _ManageSubscriptionPageState extends State<ManageSubscriptionPage> {
  String _currentPlan = 'Premium';
  String _billingCycle = 'Monthly';
  double _monthlyPrice = 29.99;
  DateTime _nextBillingDate = DateTime.now().add(const Duration(days: 30));
  bool _autoRenewal = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Manage Subscription',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Subscription Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.redAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Plan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _currentPlan,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Active',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$_billingCycle • \$$_monthlyPrice/month',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Next billing: ${_nextBillingDate.day}/${_nextBillingDate.month}/${_nextBillingDate.year}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Subscription Features
            Text(
              'Premium Features',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            _buildFeatureItem(
              icon: Icons.fitness_center,
              title: 'Unlimited Workouts',
              description: 'Access to all workout programs and exercises',
            ),

            _buildFeatureItem(
              icon: Icons.restaurant,
              title: 'Personalized Diet Plans',
              description: 'Custom meal plans based on your goals',
            ),

            _buildFeatureItem(
              icon: Icons.person,
              title: '1-on-1 Trainer Access',
              description: 'Direct messaging with certified trainers',
            ),

            _buildFeatureItem(
              icon: Icons.analytics,
              title: 'Progress Tracking',
              description: 'Detailed analytics and progress reports',
            ),

            const SizedBox(height: 32),

            // Billing Information
            Text(
              'Billing Information',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildBillingInfoRow('Plan', _currentPlan),
                  const SizedBox(height: 12),
                  _buildBillingInfoRow('Billing Cycle', _billingCycle),
                  const SizedBox(height: 12),
                  _buildBillingInfoRow('Monthly Price', '\$$_monthlyPrice'),
                  const SizedBox(height: 12),
                  _buildBillingInfoRow('Next Billing Date', '${_nextBillingDate.day}/${_nextBillingDate.month}/${_nextBillingDate.year}'),
                  const SizedBox(height: 12),
                  _buildBillingInfoRow('Auto Renewal', _autoRenewal ? 'Enabled' : 'Disabled'),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Subscription Options
            Text(
              'Subscription Options',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            // Change Plan Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showPlanChangeDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Change Plan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Billing Settings Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  _showBillingSettings();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Billing Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Cancel Subscription Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  _showCancelDialog();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Cancel Subscription',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.red, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
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
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
        ],
      ),
    );
  }

  Widget _buildBillingInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void _showPlanChangeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          title: const Text(
            'Change Subscription Plan',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPlanOption('Basic', '\$9.99/month', 'Limited features'),
              const SizedBox(height: 12),
              _buildPlanOption('Premium', '\$29.99/month', 'All features included'),
              const SizedBox(height: 12),
              _buildPlanOption('Pro', '\$49.99/month', 'Advanced features + coaching'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlanOption(String name, String price, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: name == _currentPlan ? Colors.red.withOpacity(0.2) : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: name == _currentPlan ? Colors.red : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: name == _currentPlan ? Colors.red : Colors.white,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: name == _currentPlan ? Colors.red : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showBillingSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          title: const Text(
            'Billing Settings',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text(
                  'Auto Renewal',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Automatically renew subscription',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                value: _autoRenewal,
                onChanged: (value) {
                  setState(() {
                    _autoRenewal = value;
                  });
                },
                activeColor: Colors.red,
              ),
              ListTile(
                title: const Text(
                  'Payment Method',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '•••• •••• •••• 1234',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  // TODO: Navigate to payment method management
                },
              ),
              ListTile(
                title: const Text(
                  'Billing History',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'View past invoices and payments',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  // TODO: Navigate to billing history
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          title: const Text(
            'Cancel Subscription',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to cancel your subscription? You will lose access to premium features at the end of your current billing period.',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Keep Subscription',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Subscription cancelled successfully'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              child: const Text(
                'Cancel Subscription',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

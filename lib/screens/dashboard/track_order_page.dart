import 'package:flutter/material.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({Key? key}) : super(key: key);

  @override
  _TrackOrderPageState createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  String _orderStatus = 'In Transit';
  String _estimatedDelivery = 'Dec 15, 2024';
  String _trackingNumber = 'FF20241210001';
  String _orderDate = 'Dec 10, 2024';

  final List<Map<String, dynamic>> _orderTimeline = [
    {
      'status': 'Order Placed',
      'date': 'Dec 10, 2024 10:30 AM',
      'completed': true,
      'icon': Icons.shopping_cart_checkout,
    },
    {
      'status': 'Payment Confirmed',
      'date': 'Dec 10, 2024 10:32 AM',
      'completed': true,
      'icon': Icons.payment,
    },
    {
      'status': 'Processing',
      'date': 'Dec 10, 2024 02:15 PM',
      'completed': true,
      'icon': Icons.inventory,
    },
    {
      'status': 'Shipped',
      'date': 'Dec 11, 2024 09:45 AM',
      'completed': true,
      'icon': Icons.local_shipping,
    },
    {
      'status': 'In Transit',
      'date': 'Dec 12, 2024 08:20 AM',
      'completed': true,
      'icon': Icons.airplane_ticket,
    },
    {
      'status': 'Out for Delivery',
      'date': 'Expected: Dec 15, 2024',
      'completed': false,
      'icon': Icons.local_shipping,
    },
    {
      'status': 'Delivered',
      'date': 'Expected: Dec 15, 2024',
      'completed': false,
      'icon': Icons.check_circle,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Track Order',
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
            // Order Status Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade700, width: 1),
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
                            'Order #$_trackingNumber',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ordered on $_orderDate',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
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
                          color: _getStatusColor(_orderStatus).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _getStatusColor(_orderStatus),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          _orderStatus,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(_orderStatus),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Progress Bar
                  LinearProgressIndicator(
                    value: _getProgressValue(_orderStatus),
                    backgroundColor: Colors.grey.shade700,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getStatusColor(_orderStatus),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimated Delivery',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            _estimatedDelivery,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Tracking Number',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            _trackingNumber,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Order Timeline
            Text(
              'Order Timeline',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _orderTimeline.length,
              itemBuilder: (context, index) {
                final item = _orderTimeline[index];
                return _buildTimelineItem(
                  icon: item['icon'],
                  status: item['status'],
                  date: item['date'],
                  completed: item['completed'],
                  isLast: index == _orderTimeline.length - 1,
                );
              },
            ),

            const SizedBox(height: 32),

            // Order Items
            Text(
              'Order Items',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            _buildOrderItem(
              name: 'Premium Whey Protein',
              brand: 'Optimum Nutrition',
              quantity: 2,
              price: 59.99,
              image: 'assets/images/gold_standard_whey.jpg',
            ),

            _buildOrderItem(
              name: 'Pre-Workout Formula',
              brand: 'Cellucor C4',
              quantity: 1,
              price: 32.99,
              image: 'assets/images/c4_preworkout.jpg',
            ),

            const SizedBox(height: 24),

            // Order Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSummaryRow('Subtotal (3 items)', '\$152.97'),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Shipping', '\$9.99'),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Tax', '\$12.24'),
                  const Divider(color: Color(0xFF757575), height: 16),
                  _buildSummaryRow(
                    'Total',
                    '\$175.20',
                    isBold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Contact support
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Contact Support',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Reorder items
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
                      'Reorder',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String status,
    required String date,
    required bool completed,
    required bool isLast,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: completed ? Colors.green.withOpacity(0.2) : Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: completed ? Colors.green : Colors.grey.shade600,
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  color: completed ? Colors.green : Colors.grey,
                  size: 20,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 40,
                  color: completed ? Colors.green : Colors.grey.shade600,
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: completed ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          if (completed)
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required String name,
    required String brand,
    required int quantity,
    required double price,
    required String image,
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
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
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
                Text(
                  brand,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
                Text(
                  'Quantity: $quantity',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${(price * quantity).toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade400,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  double _getProgressValue(String status) {
    switch (status) {
      case 'Order Placed':
        return 0.1;
      case 'Payment Confirmed':
        return 0.2;
      case 'Processing':
        return 0.4;
      case 'Shipped':
        return 0.6;
      case 'In Transit':
        return 0.8;
      case 'Out for Delivery':
        return 0.9;
      case 'Delivered':
        return 1.0;
      default:
        return 0.0;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Order Placed':
      case 'Payment Confirmed':
      case 'Processing':
        return Colors.blue;
      case 'Shipped':
      case 'In Transit':
        return Colors.orange;
      case 'Out for Delivery':
        return Colors.purple;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Workout Reminder',
      'message': 'Don\'t forget your evening yoga session at 6:00 PM!',
      'time': '2 hours ago',
      'type': 'workout',
      'isRead': false,
      'icon': Icons.fitness_center,
    },
    {
      'id': '2',
      'title': 'Achievement Unlocked!',
      'message': 'Congratulations! You\'ve completed your 7-day workout streak.',
      'time': '5 hours ago',
      'type': 'achievement',
      'isRead': false,
      'icon': Icons.emoji_events,
    },
    {
      'id': '3',
      'title': 'Subscription Update',
      'message': 'Your premium subscription has been renewed successfully.',
      'time': '1 day ago',
      'type': 'subscription',
      'isRead': true,
      'icon': Icons.credit_card,
    },
    {
      'id': '4',
      'title': 'New Workout Available',
      'message': 'Check out our new HIIT workout program in your dashboard.',
      'time': '2 days ago',
      'type': 'content',
      'isRead': true,
      'icon': Icons.add_circle_outline,
    },
    {
      'id': '5',
      'title': 'Weekly Progress Report',
      'message': 'You\'ve burned 2,340 calories this week. Great job!',
      'time': '3 days ago',
      'type': 'progress',
      'isRead': true,
      'icon': Icons.analytics,
    },
    {
      'id': '6',
      'title': 'Trainer Message',
      'message': 'Hi! I\'ve reviewed your form. Let\'s schedule a quick call.',
      'time': '4 days ago',
      'type': 'trainer',
      'isRead': false,
      'icon': Icons.person,
    },
    {
      'id': '7',
      'title': 'App Update',
      'message': 'New features available! Update your app for the best experience.',
      'time': '5 days ago',
      'type': 'update',
      'isRead': true,
      'icon': Icons.system_update,
    },
  ];

  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _calculateUnreadCount();
  }

  void _calculateUnreadCount() {
    setState(() {
      _unreadCount = _notifications.where((notification) => !notification['isRead']).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Notifications',
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
        actions: [
          if (_notifications.isNotEmpty)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Mark All Read',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with unread count
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.notifications_outlined, color: Colors.red, size: 24),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$_unreadCount Unread Notifications',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Stay updated with your fitness journey',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Notifications List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      return _buildNotificationItem(notification);
                    },
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.grey,
              size: 48,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re all caught up! We\'ll notify you when something important happens.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // TODO: Refresh notifications or navigate back
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final isUnread = !notification['isRead'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isUnread ? Colors.grey.shade800 : Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnread ? Colors.red.withOpacity(0.3) : Colors.transparent,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _getNotificationColor(notification['type']).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            notification['icon'],
            color: _getNotificationColor(notification['type']),
            size: 24,
          ),
        ),
        title: Text(
          notification['title'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification['message'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade300,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              notification['time'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isUnread)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () => _deleteNotification(notification['id']),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        onTap: () => _markAsRead(notification['id']),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'workout':
        return Colors.green;
      case 'achievement':
        return Colors.orange;
      case 'subscription':
        return Colors.blue;
      case 'content':
        return Colors.purple;
      case 'progress':
        return Colors.teal;
      case 'trainer':
        return Colors.red;
      case 'update':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final notification = _notifications.firstWhere((n) => n['id'] == notificationId);
      notification['isRead'] = true;
      _calculateUnreadCount();
    });

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification marked as read'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
      _unreadCount = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteNotification(String notificationId) {
    setState(() {
      _notifications.removeWhere((n) => n['id'] == notificationId);
      _calculateUnreadCount();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification deleted'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

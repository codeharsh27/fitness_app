import 'package:flutter/material.dart';

class MessageSupportPage extends StatefulWidget {
  const MessageSupportPage({Key? key}) : super(key: key);

  @override
  _MessageSupportPageState createState() => _MessageSupportPageState();
}

class _MessageSupportPageState extends State<MessageSupportPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'message': 'Hi! How can I help you today?',
      'time': '10:30 AM',
      'sender': 'Support Team',
    },
    {
      'isUser': true,
      'message': 'I have an issue with my subscription',
      'time': '10:32 AM',
      'sender': 'You',
    },
    {
      'isUser': false,
      'message':
          'I\'d be happy to help! Can you please describe the issue you\'re experiencing?',
      'time': '10:33 AM',
      'sender': 'Support Team',
    },
  ];

  final List<Map<String, dynamic>> _supportOptions = [
    {
      'title': 'Subscription Issues',
      'subtitle': 'Billing, cancellation, plan changes',
      'icon': Icons.credit_card,
    },
    {
      'title': 'Technical Support',
      'subtitle': 'App crashes, login issues, features',
      'icon': Icons.computer,
    },
    {
      'title': 'Order Problems',
      'subtitle': 'Missing items, wrong products, delivery',
      'icon': Icons.local_shipping,
    },
    {
      'title': 'Account Help',
      'subtitle': 'Profile, password, personal info',
      'icon': Icons.person,
    },
    {
      'title': 'General Questions',
      'subtitle': 'Features, pricing, getting started',
      'icon': Icons.help_outline,
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Support Center',
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
            // Quick Help Section
            Text(
              'How can we help you?',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: _supportOptions.length,
              itemBuilder: (context, index) {
                final option = _supportOptions[index];
                return _buildSupportOption(
                  title: option['title'],
                  subtitle: option['subtitle'],
                  icon: option['icon'],
                  onTap: () => _startChat(option['title']),
                );
              },
            ),

            const SizedBox(height: 16),

            // Contact Information
            Text(
              'Contact Information',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            _buildContactCard(
              title: 'Email Support',
              subtitle: 'support@fitnessapp.com',
              icon: Icons.email,
              onTap: () {
                // TODO: Launch email client
              },
            ),

            _buildContactCard(
              title: 'Phone Support',
              subtitle: '+1 (555) 123-4567',
              icon: Icons.phone,
              onTap: () {
                // TODO: Launch phone dialer
              },
            ),

            _buildContactCard(
              title: 'Live Chat',
              subtitle: 'Available 24/7',
              icon: Icons.chat,
              onTap: () {
                _startLiveChat();
              },
            ),

            const SizedBox(height: 24),

            // FAQ Section
            Text(
              'Frequently Asked Questions',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            _buildFAQItem(
              question: 'How do I cancel my subscription?',
              answer:
                  'Go to Profile > Manage Subscription > Cancel Subscription to cancel your plan.',
            ),

            _buildFAQItem(
              question: 'How do I track my order?',
              answer:
                  'Go to Profile > Track Order to view your order status and delivery information.',
            ),

            _buildFAQItem(
              question: 'How do I change my password?',
              answer:
                  'Go to Profile > Edit Profile and update your account information.',
            ),

            _buildFAQItem(
              question: 'What payment methods do you accept?',
              answer:
                  'We accept all major credit cards, PayPal, and digital wallets.',
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade700, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(icon, color: Colors.red, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.red, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 16,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.help_outline, color: Colors.red, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade300,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _startChat(String topic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          title: Text(
            'Start Chat - $topic',
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(
            'You\'ll be connected with our support team who specializes in $topic. Please describe your issue and we\'ll help you right away.',
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showChatInterface(topic);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Chat'),
            ),
          ],
        );
      },
    );
  }

  void _showChatInterface(String topic) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade900,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              // Chat Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.chat, color: Colors.red, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      '$topic Support',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Messages List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _buildChatMessage(
                      message: message['message'],
                      time: message['time'],
                      isUser: message['isUser'],
                      sender: message['sender'],
                    );
                  },
                ),
              ),

              // Message Input
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade600, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: Colors.grey.shade600),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: Colors.grey.shade600),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade700,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        maxLines: null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChatMessage({
    required String message,
    required String time,
    required bool isUser,
    required String sender,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUser ? Colors.red : Colors.grey.shade700,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isUser ? 'You • $time' : '$sender • $time',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'isUser': true,
          'message': _messageController.text.trim(),
          'time':
              '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')} ${TimeOfDay.now().period.name.toUpperCase()}',
          'sender': 'You',
        });
      });
      _messageController.clear();
    }
  }

  void _startLiveChat() {
    _showChatInterface('General');
  }
}

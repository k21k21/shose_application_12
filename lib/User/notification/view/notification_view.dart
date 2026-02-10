import 'package:flutter/material.dart';

// A model class to hold notification data
class NotificationItem {
  final String title;
  final String message;
  final String timeAgo;
  final IconData icon;
  final Color iconColor;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    this.isRead = false,
  });
}

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  // A list of notifications, you would typically fetch this from an API
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'App Update',
      message:
          'New update out now! Discover improved productivity tools and more.',
      timeAgo: '2 days ago',
      icon: Icons.check_circle,
      iconColor: Colors.green,
    ),
    NotificationItem(
      title: 'Upgrade Offer',
      message:
          'Get Lumina Premium now at 40% off for advanced productivity features!',
      timeAgo: '2 days ago',
      icon: Icons.new_releases,
      iconColor: Colors.orange,
    ),
  ];

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  void _markAsRead(int index) {
    setState(() {
      _notifications[index].isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'NOTIFICATIONS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    notification.icon,
                    color: notification.iconColor,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification.message,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notification.timeAgo,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'read') {
                        _markAsRead(index);
                      } else if (value == 'delete') {
                        _deleteNotification(index);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'read',
                            child: Text('Mark as read'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                    child: const Icon(Icons.more_vert, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

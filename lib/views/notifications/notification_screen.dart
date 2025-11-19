import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'New Message',
      description: 'You have received a new message from Sarah',
      time: '2 min ago',
      icon: Icons.message,
      color: Colors.blue,
      isRead: false,
    ),
    NotificationItem(
      title: 'Payment Successful',
      description: 'Your payment of \$49.99 has been processed',
      time: '1 hour ago',
      icon: Icons.check_circle,
      color: Colors.green,
      isRead: false,
    ),
    NotificationItem(
      title: 'System Update',
      description: 'A new version is available for download',
      time: '3 hours ago',
      icon: Icons.system_update,
      color: Colors.orange,
      isRead: true,
    ),
    // NotificationItem(
    //   title: 'Event Reminder',
    //   description: 'Your meeting starts in 30 minutes',
    //   time: '5 hours ago',
    //   icon: Icons.event,
    //   color: Colors.purple,
    //   isRead: true,
    // ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.done_all, color: Colors.black54),
        //     onPressed: () {
        //       // Mark all as read
        //     },
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.settings_outlined, color: Colors.black54),
        //     onPressed: () {
        //       // Settings
        //     },
        //   ),
        // ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final delay = index * 0.1;
              final animation = Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(delay, delay + 0.3, curve: Curves.easeOut),
                ),
              );

              return Transform.translate(
                offset: Offset(0, 50 * (1 - animation.value)),
                child: Opacity(opacity: animation.value, child: child),
              );
            },
            child: NotificationCard(
              notification: notifications[index],
              onTap: () {
                setState(() {
                  notifications[index].isRead = true;
                });
              },
              onDismiss: () {
                setState(() {
                  notifications.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final NotificationItem notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.notification.title + widget.notification.time),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => widget.onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.notification.isRead
                  ? Colors.white
                  : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: widget.notification.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.notification.icon,
                    color: widget.notification.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.notification.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: widget.notification.isRead
                                    ? FontWeight.w500
                                    : FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          if (!widget.notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.notification.description,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.notification.time,
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
    this.isRead = false,
  });
}

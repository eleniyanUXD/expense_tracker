import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String? userName;

  const DashboardHeader({super.key, required this.userName});

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning,';
    } else if (hour < 17) {
      return 'Good afternoon,';
    } else {
      return 'Good evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 26,
          backgroundColor: Color.fromARGB(255, 228, 228, 228),
          child: Icon(Icons.person, color: Colors.blueGrey, size: 30),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
              ),
              const SizedBox(height: 4),
              Text(
                userName ?? 'User',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ),
      ],
    );
  }
}

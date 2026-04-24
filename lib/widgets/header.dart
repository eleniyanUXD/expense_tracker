import 'package:flutter/material.dart';

Widget _buildHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Left side text
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text('Fuad', style: TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),

      // Right side avatar
      CircleAvatar(
        radius: 20,
        backgroundColor: Colors.black,
        child: Icon(Icons.person, color: Colors.white),
      ),
    ],
  );
}

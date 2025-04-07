import 'package:flutter/material.dart';

Widget buildHistory() {
  return Container(
    height: 520,
    width: 400,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.deepPurple),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Previous Task History",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          // TODO: Create a ListView.builder to show list tiles of history created by the user
        ],
      ),
    ),
  );
}
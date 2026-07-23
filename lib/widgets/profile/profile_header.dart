import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../utills/app_constant.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: user.userImg.isEmpty
                ? null
                : NetworkImage(user.userImg),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(user.email, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
            ),
            onPressed: () {},
            child: const Text("Edit"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileItem {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  ProfileItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });
}

class ProfileTile extends StatelessWidget {
  final ProfileItem item;

  const ProfileTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon),

      title: Text(item.title),

      trailing: item.trailing ?? const Icon(Icons.chevron_right),

      onTap: item.onTap,
    );
  }
}

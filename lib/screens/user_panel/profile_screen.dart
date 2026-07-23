import 'package:e_commerce/screens/auth_ui/wellcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/profile_controller/profile_controller.dart';
import '../../widgets/profile/profile_header.dart';
import '../../widgets/profile/profile_section.dart';
import '../../widgets/profile/profile_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(profileProvider);
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          userAsync.when(
            data: (user) => ProfileHeader(user: user),

            loading: () => const Center(child: CircularProgressIndicator()),

            error: (e, s) => Center(child: Text(e.toString())),
          ),
          const SizedBox(height: 20),

          ProfileSection(
            title: "My Account",
            items: [
              ProfileItem(
                icon: Icons.shopping_bag_outlined,
                title: "My Orders",
                onTap: () {},
              ),

              ProfileItem(
                icon: Icons.favorite_border,
                title: "Wishlist",
                onTap: () {},
              ),

              ProfileItem(
                icon: Icons.location_on_outlined,
                title: "Addresses",
                onTap: () {},
              ),

              ProfileItem(
                icon: Icons.payment_outlined,
                title: "Payment Methods",
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 20),

          ProfileSection(
            title: "Settings",
            items: [
              ProfileItem(
                icon: Icons.notifications_none,
                title: "Notifications",
                onTap: () {},
              ),

              ProfileItem(
                icon: Icons.language,
                title: "Language",
                onTap: () {},
              ),

              ProfileItem(
                icon: Icons.dark_mode_outlined,
                title: "Dark Mode",
                trailing: Switch(value: false, onChanged: (v) {}),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ProfileSection(
            title: "Support",
            items: [
              ProfileItem(
                icon: Icons.help_outline,
                title: "Help Center",
                onTap: () {},
              ),

              ProfileItem(
                icon: Icons.privacy_tip_outlined,
                title: "Privacy Policy",
                onTap: () {},
              ),

              ProfileItem(
                icon: Icons.info_outline,
                title: "About",
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 54,
            child: OutlinedButton.icon(
              onPressed: () async {
                await ref.read(profileProvider.notifier).logout();

                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const WellcomeScreen()),
                        (route) => false,
                  );
                }
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              "Version 1.0.0",
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce/controllers/sign_in_controller.dart';
import 'package:e_commerce/screens/admin_panel/admin_home_main_screen.dart';
import 'package:e_commerce/screens/auth_ui/login_in_screen.dart';
import 'package:e_commerce/screens/auth_ui/splash_screen.dart';
import 'package:e_commerce/screens/auth_ui/wellcome_screen.dart';
import 'package:e_commerce/screens/user_panel/main_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(signinProvider);

    return authState.when(
      loading: () => const SplashScreen(),

      error: (e, s) => const LoginInScreen(),

      data: (user) {
        if (user == null) {
          return const WellcomeScreen();
        }

        if (user.isAdmin == true) {
          return const AdminHomeMainScreen();
        }

        return const MainScreen();
      },
    );
  }
}

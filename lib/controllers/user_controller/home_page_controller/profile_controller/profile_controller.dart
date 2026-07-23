import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user_model.dart';
import '../../../../services/firestore_service.dart';

final profileProvider = StreamNotifierProvider<ProfileNotifier, UserModel>(
  ProfileNotifier.new,
);

class ProfileNotifier extends StreamNotifier<UserModel> {
  final _service = FirestoreService.instance;

  @override
  Stream<UserModel> build() {
    return _service.userStream();
  }

  Future<void> updateProfile(UserModel user) async {
    await _service.updateUser(user);
  }

  Future<void> logout() async {
    await _service.logout();
  }
}

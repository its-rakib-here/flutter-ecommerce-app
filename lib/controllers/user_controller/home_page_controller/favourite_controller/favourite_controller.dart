import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/firestore_service.dart';

final favouriteProvider =
    StreamNotifierProvider<FavouriteNotifier, Set<String>>(
      FavouriteNotifier.new,
    );

class FavouriteNotifier extends StreamNotifier<Set<String>> {
  final _service = FirestoreService.instance;

  @override
  Stream<Set<String>> build() {
    return _service.favouriteStream();
  }

  Future<void> toggleFavourite(String productId) async {
    final current = state.value ?? {};

    if (current.contains(productId)) {
      await _service.removeFavourite(productId);
    } else {
      await _service.addFavourite(productId);
    }
  }
}

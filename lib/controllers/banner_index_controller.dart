import 'package:flutter_riverpod/flutter_riverpod.dart';

final bannerIndexPorovider =
    NotifierProvider<BannerIndexNotifierController, int>(
      BannerIndexNotifierController.new,
    );

class BannerIndexNotifierController extends Notifier<int> {
  @override
  int build() => 0;

  void changeIndex(int index) {
    state = index;
  }
}

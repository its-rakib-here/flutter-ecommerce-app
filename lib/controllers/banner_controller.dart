import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/banner_model.dart';
import '../services/banner_service.dart';

final bannerControllerProvider =
    AsyncNotifierProvider<BannerController, List<BannerModel>>(
      BannerController.new,
    );

class BannerController extends AsyncNotifier<List<BannerModel>> {
  final BannerService _bannerService = BannerService();

  @override
  FutureOr<List<BannerModel>> build() async {
    return await _bannerService.getBanners();
  }

  Future<void> loadBanners() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _bannerService.getBanners();
    });
  }

  Future<void> refreshBanner() async {
    await loadBanners();
  }
}

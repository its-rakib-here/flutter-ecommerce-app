import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/address_model.dart';
import '../../../../services/checkout_service/address_service.dart';

final addressProvider =
    StreamNotifierProvider<AddressNotifier, List<AddressModel>>(
      AddressNotifier.new,
    );

class AddressNotifier extends StreamNotifier<List<AddressModel>> {
  final _service = AddressService.instance;

  @override
  Stream<List<AddressModel>> build() {
    return _service.addressStream();
  }

  Future<void> addAddress(AddressModel address) async {
    await _service.addAddress(address);
  }

  Future<void> updateAddress(AddressModel address) async {
    await _service.updateAddress(address);
  }

  Future<void> deleteAddress(String addressId) async {
    await _service.deleteAddress(addressId);
  }

  Future<void> setDefaultAddress(String addressId) async {
    await _service.setDefaultAddress(addressId);
  }

  Future<AddressModel?> getDefaultAddress() async {
    return await _service.getDefaultAddress();
  }
}

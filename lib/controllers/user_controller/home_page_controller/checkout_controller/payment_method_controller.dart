import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/payment_method_model.dart';
import '../../../../services/checkout_service/payment_method_service.dart';

final paymentMethodProvider =
    StreamNotifierProvider<PaymentMethodNotifier, List<PaymentMethodModel>>(
      PaymentMethodNotifier.new,
    );

class PaymentMethodNotifier extends StreamNotifier<List<PaymentMethodModel>> {
  final PaymentMethodService _service = PaymentMethodService.instance;

  @override
  Stream<List<PaymentMethodModel>> build() {
    return _service.paymentMethodsStream();
  }

  Future<void> addPaymentMethod(PaymentMethodModel payment) async {
    await _service.addPaymentMethod(payment);
  }

  Future<void> updatePaymentMethod(PaymentMethodModel payment) async {
    await _service.updatePaymentMethod(payment);
  }

  Future<void> deletePaymentMethod(String paymentId) async {
    await _service.deletePaymentMethod(paymentId);
  }

  Future<void> setDefaultPaymentMethod(String paymentId) async {
    await _service.setDefaultPaymentMethod(paymentId);
  }

  Future<PaymentMethodModel?> getDefaultPaymentMethod() async {
    return await _service.getDefaultPaymentMethod();
  }
}

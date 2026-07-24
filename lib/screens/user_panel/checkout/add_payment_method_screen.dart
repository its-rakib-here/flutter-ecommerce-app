import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/user_controller/home_page_controller/checkout_controller/payment_method_controller.dart';
import '../../../models/payment_method_model.dart';

class AddPaymentMethodScreen extends ConsumerStatefulWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  ConsumerState<AddPaymentMethodScreen> createState() =>
      _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState
    extends ConsumerState<AddPaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();

  PaymentType _type = PaymentType.visa;

  final _holderController = TextEditingController();
  final _cardController = TextEditingController();
  final _phoneController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _nicknameController = TextEditingController();

  @override
  void dispose() {
    _holderController.dispose();
    _cardController.dispose();
    _phoneController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  bool get _isCard =>
      _type == PaymentType.visa || _type == PaymentType.mastercard;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final id = FirebaseFirestore.instance.collection("tmp").doc().id;

      final payment = PaymentMethodModel(
        id: id,
        userId: FirebaseAuth.instance.currentUser!.uid,
        type: _type,
        nickname: _nicknameController.text.trim(),
        holderName: _holderController.text.trim(),
        last4: _isCard
            ? _cardController.text.trim().substring(
                _cardController.text.length - 4,
              )
            : "",
        expiryMonth: _isCard ? int.parse(_monthController.text) : 0,
        expiryYear: _isCard ? int.parse(_yearController.text) : 0,
        phone: _isCard ? "" : _phoneController.text.trim(),
        isDefault: false,
        createdAt: Timestamp.now(),
      );

      print(payment.toMap());

      await ref.read(paymentMethodProvider.notifier).addPaymentMethod(payment);

      print("Saved Successfully");

      if (mounted) Navigator.pop(context);
    } catch (e, st) {
      print("SAVE ERROR: $e");
      print(st);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Payment Method")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<PaymentType>(
              value: _type,
              decoration: const InputDecoration(labelText: "Payment Type"),
              items: PaymentType.values.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            if (_isCard) ...[
              TextFormField(
                controller: _holderController,
                decoration: const InputDecoration(
                  labelText: "Card Holder Name",
                ),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _cardController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Card Number"),
                validator: (v) {
                  if (v == null || v.length < 16) {
                    return "Enter a valid card number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  labelText: "Nickname",
                  hintText: "Personal Visa",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Nickname is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _monthController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Month"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextFormField(
                      controller: _yearController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Year"),
                    ),
                  ),
                ],
              ),
            ] else ...[
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Phone Number"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
            ],

            const SizedBox(height: 30),

            FilledButton(
              onPressed: _save,
              child: const Text("Save Payment Method"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/user_controller/home_page_controller/checkout_controller/address_controller.dart';
import '../../../models/address_model.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({super.key});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _postalController = TextEditingController();

  bool isDefault = true;
  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  Future<void> saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      final address = AddressModel(
        id: "",
        userId: "",
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        country: _countryController.text.trim(),
        city: _cityController.text.trim(),
        street: _streetController.text.trim(),
        postalCode: _postalController.text.trim(),
        isDefault: isDefault,
        createdAt: Timestamp.now(),
      );

      await ref.read(addressProvider.notifier).addAddress(address);

      if (mounted) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Address Added Successfully")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  String? validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Address")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: inputDecoration("Full Name"),
              validator: validator,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: inputDecoration("Phone"),
              validator: validator,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _countryController,
              decoration: inputDecoration("Country"),
              validator: validator,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _cityController,
              decoration: inputDecoration("City"),
              validator: validator,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _streetController,
              decoration: inputDecoration("Street Address"),
              validator: validator,
              maxLines: 2,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _postalController,
              decoration: inputDecoration("Postal Code"),
            ),

            const SizedBox(height: 20),

            SwitchListTile(
              value: isDefault,
              title: const Text("Set as Default Address"),
              onChanged: (value) {
                setState(() {
                  isDefault = value;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : saveAddress,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Save Address",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

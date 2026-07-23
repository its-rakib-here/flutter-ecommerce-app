import 'package:e_commerce/screens/user_panel/checkout/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/user_controller/home_page_controller/checkout_controller/address_controller.dart';
import '../../../models/address_model.dart';
import '../../../models/cart_product_model.dart';
import '../../../utills/app_constant.dart';
import '../../../widgets/checkout/checkout_address_card.dart';
import '../../../widgets/checkout/checkout_product_tile.dart';
import '../../../widgets/checkout/payment_method_card.dart';
import '../../../widgets/checkout/place_order_button.dart';
import '../../../widgets/checkout/price_summary_card.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final List<CartProductModel> items;
  final bool fromCart;

  const CheckoutScreen({
    super.key,
    required this.items,
    required this.fromCart,
  });

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  AddressModel? _selectedAddress;

  String _paymentMethod = AppConstants.cashOnDelivery;

  double get subtotal =>
      widget.items.fold(0, (sum, item) => sum + item.subtotal);

  double get deliveryFee => 60;

  double get discount => 0;

  double get total => subtotal + deliveryFee - discount;

  @override
  Widget build(BuildContext context) {
    final addressAsync = ref.watch(addressProvider);

    addressAsync.whenData((addresses) {
      if (_selectedAddress == null && addresses.isNotEmpty) {
        _selectedAddress = addresses.firstWhere(
          (e) => e.isDefault,
          orElse: () => addresses.first,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: addressAsync.when(
        data: (addresses) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CheckoutAddressCard(
                  address: _selectedAddress,
                  onTap: () {
                    // Address selection screen later
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAddressScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, index) {
                    return CheckoutProductTile(item: widget.items[index]);
                  },
                ),

                const SizedBox(height: 20),

                PaymentMethodCard(
                  selectedMethod: _paymentMethod,
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      _paymentMethod = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                PriceSummaryCard(
                  subtotal: subtotal,
                  deliveryFee: deliveryFee,
                  discount: discount,
                  total: total,
                ),

                const SizedBox(height: 30),

                PlaceOrderButton(
                  address: _selectedAddress,
                  cartItems: widget.items,
                  paymentMethod: _paymentMethod,
                  fromCart: widget.fromCart,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text("Something went wrong")),
      ),
    );
  }
}

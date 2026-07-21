import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    /// Later this will come from Riverpod
    const bool isCartEmpty = false;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(title: Text("Cart")),
      body: Column(),
    );
  }
}

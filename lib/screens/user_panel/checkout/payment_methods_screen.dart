import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/user_controller/home_page_controller/checkout_controller/payment_method_controller.dart';
import '../../../models/payment_method_model.dart';
import 'add_payment_method_screen.dart' show AddPaymentMethodScreen;

class PaymentMethodsScreen extends ConsumerWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethods = ref.watch(paymentMethodProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Payment Methods")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPaymentMethodScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
      body: paymentMethods.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),

        data: (payments) {
          if (payments.isEmpty) {
            return const Center(child: Text("No payment methods added"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      payment.isCard
                          ? Icons.credit_card
                          : Icons.account_balance_wallet,
                    ),
                  ),

                  title: Text(_title(payment)),

                  subtitle: Text(_subtitle(payment)),

                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      switch (value) {
                        case "default":
                          await ref
                              .read(paymentMethodProvider.notifier)
                              .setDefaultPaymentMethod(payment.id);
                          break;

                        case "delete":
                          await ref
                              .read(paymentMethodProvider.notifier)
                              .deletePaymentMethod(payment.id);
                          break;
                      }
                    },
                    itemBuilder: (_) => [
                      if (!payment.isDefault)
                        const PopupMenuItem(
                          value: "default",
                          child: Text("Set Default"),
                        ),
                      const PopupMenuItem(
                        value: "delete",
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _title(PaymentMethodModel payment) {
    switch (payment.type) {
      case PaymentType.visa:
        return "Visa";

      case PaymentType.mastercard:
        return "Mastercard";

      case PaymentType.bkash:
        return "bKash";

      case PaymentType.nagad:
        return "Nagad";
    }
  }

  String _subtitle(PaymentMethodModel payment) {
    if (payment.isCard) {
      return "**** **** **** ${payment.last4}"
          "${payment.isDefault ? "\nDefault" : ""}";
    }

    return "${payment.phone}"
        "${payment.isDefault ? "\nDefault" : ""}";
  }
}

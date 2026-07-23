import 'package:flutter/material.dart';

import '../../../utills/app_constant.dart';

class OrderTimeline extends StatelessWidget {
  final String currentStatus;

  const OrderTimeline({super.key, required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    final currentIndex = AppConstants.orderFlow.indexOf(currentStatus);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Order Timeline",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            ...List.generate(AppConstants.orderFlow.length, (index) {
              final status = AppConstants.orderFlow[index];

              final completed = index <= currentIndex;

              final isLast = index == AppConstants.orderFlow.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: completed
                              ? Colors.green
                              : Colors.grey.shade300,
                          child: completed
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14,
                                )
                              : null,
                        ),

                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: completed
                                  ? Colors.green
                                  : Colors.grey.shade300,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontWeight: completed
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: completed ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

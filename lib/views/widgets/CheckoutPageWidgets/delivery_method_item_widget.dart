import 'package:flutter/material.dart';

import '../../../models/delivery_methods_model.dart';

class DeliveryMethodItem extends StatelessWidget {
  final DeliveryMethodModel deliveryMethodModel;
  const DeliveryMethodItem({
    super.key,
    required this.deliveryMethodModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.network(
              deliveryMethodModel.imageUrl,
              fit: BoxFit.cover,
              height: 30,
            ),
            const SizedBox(height: 6.0),
            Text(
              '$deliveryMethodModel.days days',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ]),
        ),
      ),
    );
  }
}

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
      width: 200,
      height: 200,
      child: DecoratedBox(
        //  position: ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.network(
                deliveryMethodModel.imageUrl,
                fit: BoxFit.cover,
                cacheHeight: 50,
                cacheWidth: 100,
              ),
              Text(
                deliveryMethodModel.days,
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

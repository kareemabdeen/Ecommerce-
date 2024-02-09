import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                product.imgUrl,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 50,
                height: 25,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        '${product.discountValue}%',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // TODO: Create one component for the favorite button
        Positioned(
          left: MediaQuery.of(context).size.width * 0.39,
          bottom: MediaQuery.of(context).size.height * 0.075,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                )
              ],
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20.0,
              child: InkWell(
                child: Icon(
                  Icons.favorite_outline,
                  size: 20.0,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 4.0),
                  Text(
                    '(100)',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                product.category,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(height: 6.0),
              Text(
                product.title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 6.0),
              // isNew
              //     ? Text(
              //         '${product.price}\$',
              //         style: Theme.of(context).textTheme.titleSmall!.copyWith(
              //               color: Colors.grey,
              //             ),
              //       )
              //     : Text.rich(
              //         TextSpan(
              //           children: [
              //             TextSpan(
              //               text: '${product.price}\$  ',
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .titleSmall!
              //                   .copyWith(
              //                     color: Colors.grey,
              //                     decoration: TextDecoration.lineThrough,
              //                   ),
              //             ),
              //             TextSpan(
              //               text:
              //                   '  ${product.price * (product.discountValue!) / 100}\$',
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .titleSmall!
              //                   .copyWith(
              //                     color: Colors.red,
              //                   ),
              //             ),
              //           ],
              //         ),
              //       ),
            ],
          ),
        ),
      ],
    );
  }
}

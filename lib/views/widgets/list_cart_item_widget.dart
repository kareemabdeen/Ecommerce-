import 'package:flutter/material.dart';

import '../../models/user_cart_model.dart';
import '../../utilities/helpers/constants.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItem});
  final AddToCartModel cartItem;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Card(
        color: const Color(0xffFFFFFF),
        elevation: .3,
        shadowColor: Colors.black,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              child: Image.network(
                cartItem.image,
                fit: BoxFit.contain,
                cacheHeight: 200,
                cacheWidth: 200,
                height: double.infinity,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Color: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.grey,
                                      )),
                              TextSpan(
                                text: cartItem.color,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Size: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                              TextSpan(
                                text: cartItem.size,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomFloatingActionButton(
                            icon: const Icon(Icons.add),
                            // heroTag:
                            //     generateDecoumentId, //* in order each button in listview.builder to have distinct hero id
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          Text(
                            '1',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          CustomFloatingActionButton(
                            // heroTag: generateDecoumentId,
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.more_vert),
                  Text(
                    '${cartItem.price}\$  ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final Function() onPressed;
  final Widget icon;
  final Color color;
  //final Object heroTag;
  const CustomFloatingActionButton({
    required this.onPressed,
    required this.icon,
    // required this.heroTag,
    this.color = Colors.blue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: FloatingActionButton(
        backgroundColor: color,
        heroTag: generateDecoumentId,
        elevation: .4,
        shape: const CircleBorder(side: BorderSide(color: Colors.white)),
        onPressed: onPressed,
        child: icon,
      ),
    );
  }
}

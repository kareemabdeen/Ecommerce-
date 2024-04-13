import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Providers/database_controller.dart';
import '../../models/product_model.dart';
import '../../models/user_cart_model.dart';
import '../../utilities/helpers/constants.dart';
import '../widgets/drop_down_menu_widget.dart';
import '../widgets/main_button.dart';
import '../widgets/main_daliog_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavorite = false;
  late String dropdownValue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dataBase = Provider.of<DataBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imgUrl,
              width: double.infinity,
              height: size.height * 0.55,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: DropDownMenuComponent(
                            items: const ['S', 'M', 'L', 'XL', 'XXL'],
                            hint: 'Size',
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  dropdownValue = newValue!;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      // TODO: Create one component for the favorite button
                      InkWell(
                        onTap: () {
                          setState(
                            () {
                              isFavorite = !isFavorite;
                            },
                          );
                        },
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_outline_sharp,
                                color: isFavorite
                                    ? Colors.redAccent
                                    : Colors.black45,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      Text(
                        '\$${widget.product.price}',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.product.brandName,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'This is a dummy description for this product! I think we will add it in the future! I need to add more lines, so I add these words just to have more than two lines!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24.0),
                  MainButton(
                    text: 'Add to cart',
                    onTap: () => addToCart(dataBase),
                    hasCircularBorder: true,
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addToCart(DataBase dataBase) async {
    final Product selectedProduct = widget.product;
    final addToCartProduct = AddToCartModel(
      title: selectedProduct.title,
      size: dropdownValue,
      price: selectedProduct.price,
      color: selectedProduct.color ??
          'Black', //! makes error on retriving products from data base
      orginalProductId: selectedProduct.id,
      image: selectedProduct.imgUrl,
      id: generateDecoumentId,
    );

    try {
      await dataBase.addTOCart(product: addToCartProduct);

      log('add succ');
    } catch (e) {
      log(e.toString());
      if (mounted) {
        MainDialog(
          context: context,
          title: 'Error',
          content: 'Couldn`t add product to cart',
        ).showAlertDialog();
      }
    }
  }
}

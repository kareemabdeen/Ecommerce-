import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Providers/database_controller.dart';
import '../../models/user_cart_model.dart';
import '../widgets/list_cart_item_widget.dart';
import '../widgets/main_button.dart';
import '../widgets/order_summary_compenet_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int userCartPrice = 0;
  @override
  void didChangeDependencies() async {
    final userCartProducts = await Provider.of<DataBase>(context, listen: false)
        .userCartAllProducts()
        .first;

    for (var singleProduct in userCartProducts) {
      setState(
        () {
          userCartPrice += singleProduct.price;
        },
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DataBase>(context);
    return SafeArea(
      child: StreamBuilder<List<AddToCartModel>>(
        stream: database.userCartAllProducts(),
        builder: (context, snapshot) {
          //* data retrieved
          if (snapshot.connectionState == ConnectionState.active) {
            final List<AddToCartModel> cardItems = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'My Bag',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    if (cardItems.isNotEmpty)
                      ListView.builder(
                        itemBuilder: (context, index) {
                          final cardItem = cardItems[index];
                          return CartItem(cartItem: cardItem);
                        },
                        itemCount: cardItems.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    if (cardItems.isEmpty)
                      Center(
                        child: Text(
                          'Your cart is empty untill now ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    const SizedBox(height: 24.0),
                    OrderSummaryComponent(
                      title: 'Total Amount',
                      value: userCartPrice.toString(),
                    ),
                    const SizedBox(height: 32.0),
                    MainButton(
                      text: 'Checkout',
                      onTap: () {},
                      hasCircularBorder: true,
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

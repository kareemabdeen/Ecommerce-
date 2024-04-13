import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Providers/database_controller.dart';
import '../../models/delivery_methods_model.dart';
import '../widgets/CheckoutPageWidgets/delivery_method_item_widget.dart';
import '../widgets/CheckoutPageWidgets/payment_compenent.dart';
import '../widgets/CheckoutPageWidgets/shipping_address_compenent.dart';
import '../widgets/main_button.dart';
import '../widgets/order_summary_compenet_widget.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DataBase>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping address',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ShippingAddressComponent(),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Payment',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              const PaymentComponent(),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Delivery method',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   width: double.infinity,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     physics: const ClampingScrollPhysics(),
              //     children: const [
              //       DeliveryMethodItem(
              //         image: AppAssets.mastercardIcon,
              //       ),
              //       SizedBox(
              //         width: 30,
              //       ),
              //       DeliveryMethodItem(
              //         image: AppAssets.mastercardIcon,
              //       ),
              //       SizedBox(
              //         width: 30,
              //       ),
              //       DeliveryMethodItem(
              //         image: AppAssets.mastercardIcon,
              //       ),
              //     ],
              //   ),
              // ),
              StreamBuilder<List<DeliveryMethodModel>>(
                stream: database.getAvailableDeliveryMethods(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final deliveryMethods =
                        snapshot.data as List<DeliveryMethodModel>;
                    if (deliveryMethods.isEmpty) {
                      return const Center(
                        child: Text('No Delivery Methods Available '),
                      );
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return DeliveryMethodItem(
                            deliveryMethodModel: deliveryMethods[index],
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),

              const SizedBox(
                height: 50,
              ),
              OrderSummaryComponent(
                value: 112.toString(),
                title: 'Order',
              ),
              const SizedBox(
                height: 20,
              ),
              OrderSummaryComponent(
                value: 112.toString(),
                title: 'Delivery',
              ),
              const SizedBox(
                height: 20,
              ),
              OrderSummaryComponent(
                value: 112.toString(),
                title: 'Summary',
              ),
              const SizedBox(
                height: 50,
              ),
              MainButton(
                text: 'SUBMIT ORDER',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

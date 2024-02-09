import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../../utilities/assets2.dart';
import '../widgets/list_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CachedNetworkImage(
                  imageUrl: AppAssets.topBannerHomePageAsset,
                  height: MediaQuery.of(context).size.height * .3,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Opacity(
                  opacity: .3,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .3,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  child: Text(
                    'Street Clothes',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  ListHeader(
                    title: 'Sale',
                    description: "super Saummer sale",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: dummyProducts
                          .map(
                            (oneDummyProduct) => Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                              child: ProductItem(product: oneDummyProduct),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  ListHeader(
                    title: 'New',
                    description: "You`ve never seen it before ",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: dummyProducts
                          .map(
                            (oneDummyProduct) => Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                              child: ProductItem(product: oneDummyProduct),
                            ),
                          )
                          .toList(),
                    ),
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

class ListHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String description;

  const ListHeader({
    super.key,
    required this.title,
    this.onTap,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }
}

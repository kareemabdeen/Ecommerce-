import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Providers/database_controller.dart';
import '../../models/product_model.dart';
import '../../utilities/assets2.dart';
import '../widgets/list_header_widget.dart';
import '../widgets/list_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DataBase>(
      context,
      listen: false,
    );

    return SingleChildScrollView(
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
                  description: "super Summer sale",
                  onTap: () {},
                ),
                const SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  height: 330,
                  child: StreamBuilder<List<Product>>(
                    stream: database.salesProductsStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Product>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final products = snapshot.data;

                        if (products == null || products.isEmpty) {
                          return const Center(
                            child: Text('No data available '),
                          );
                        }
                        return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          padding: EdgeInsets.zero, //! recheck it
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: ListItemHome(
                              isNew: true,
                              isFavorite: true,
                              product: products[index],
                            ),
                          ),
                        );
                      } else {
                        //TODO! : customize and change it later
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 12.0,
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
                  height: 330,
                  child: StreamBuilder<List<Product>>(
                    stream: database.newsProductsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final products = snapshot.data;
                        log("sqjiqjnd {$products}");

                        if (products == null || products.isEmpty) {
                          return const Center(
                            child: Text('No data available '),
                          );
                        }
                        return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          padding: EdgeInsets.zero, //! recheck it
                          itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: ListItemHome(
                              isNew: true,
                              isFavorite: true,
                              product: products[index],
                            ),
                          ),
                        );
                      }
                      //TODO! : customize and change it later
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

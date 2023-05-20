import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/app_router.dart';
import 'package:oonzoo_app/core/cart_widget.dart';
import 'package:oonzoo_app/core/loader.dart';
import 'package:oonzoo_app/core/product_details_widget.dart';
import 'package:oonzoo_app/services/product_service.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;
  static const routeName = '/product-detail';
  final productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            AppRouter.goBack();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text('Product Details'),
        actions: [
          const CartWidget(),
          IconButton(
            onPressed: () async {},
            icon: const Icon(
              Icons.favorite_outline,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: productService.getProductById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  LoaderWidget(text: 'Fetching product details\nPlease wait!'),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text("No such Product found!"),
            );
          }

          final product = snapshot.data;
          return ProductDetailsWidget(product: product!);
        },
      ),
    );
  }
}

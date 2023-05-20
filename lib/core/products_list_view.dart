import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/app_router.dart';
import 'package:oonzoo_app/models/product.dart';
import 'package:oonzoo_app/views/product_detail_view.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return ListTile(
          onTap: () {
            AppRouter.navigateTo(
              ProductDetailView.routeName,
              args: product.id,
            );
          },
          leading: Image.network(
            product.image[0],
            fit: BoxFit.cover,
          ),
          title: Text(
            product.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '\$${product.price}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/app_router.dart';
import 'package:oonzoo_app/viewmodels/cart_viewmodel.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            AppRouter.goBack();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cartViewModel, _) {
          if (cartViewModel.products.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  const Icon(Icons.hourglass_empty_outlined, size: 60),
                  const SizedBox(height: 12),
                  const Text("Your shopping bag is empty!"),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: OutlinedButton(
                      onPressed: () {
                        AppRouter.goBack();
                      },
                      child: const Text("GO BACK"),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: cartViewModel.products.length,
            itemBuilder: (context, index) {
              final cartProduct = cartViewModel.products[index];
              return ListTile(
                key: ValueKey(index),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Image.network(
                  cartProduct.product.image.first,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  cartProduct.product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Size: ${cartProduct.size}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    cartViewModel.removeProduct(index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

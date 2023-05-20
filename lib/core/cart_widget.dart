import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/app_router.dart';
import 'package:oonzoo_app/viewmodels/cart_viewmodel.dart';
import 'package:oonzoo_app/views/cart_view.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        AppRouter.navigateTo(CartView.routeName);
      },
      icon: Stack(
        fit: StackFit.expand,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.grey,
          ),
          Consumer<CartViewModel>(builder: (context, state, child) {
            return Align(
              alignment: Alignment.topRight,
              child: Text(
                state.products.length.toString(),
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            );
          }),
        ],
      ),
    );
  }
}

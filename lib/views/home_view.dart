import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/app_router.dart';
import 'package:oonzoo_app/core/cart_widget.dart';
import 'package:oonzoo_app/core/loader.dart';
import 'package:oonzoo_app/core/products_grid_view.dart';
import 'package:oonzoo_app/services/product_service.dart';
import 'package:oonzoo_app/viewmodels/auth_viewmodel.dart';
import 'package:oonzoo_app/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  static const routeName = '/home';
  final productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(247, 245, 245, 1),
        appBar: AppBar(
          title: const Text('OOZOO Shoppee'),
          actions: [
            const CartWidget(),
            IconButton(
              onPressed: () async {
                await showGeneralDialog(
                  context: context,
                  pageBuilder: (_, animation, secondaryAnimation) {
                    return AlertDialog(
                      title: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            AppRouter.goBack();
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            AppRouter.goBack();
                            context.read<AuthViewModel>().logout();
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout, color: Colors.grey),
            ),
          ],
        ),
        body: FutureBuilder(
          future: productService.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoaderWidget(text: 'Fetching products\nPlease wait!'),
              );
            }
            if (snapshot.data?.isEmpty ?? true) {
              return const Center(
                child: Text("No Products found!"),
              );
            }

            return Consumer<HomeViewModel>(builder: (context, state, child) {
              return ProductsGridView(products: snapshot.data ?? []);
            });
          },
        ),
      ),
    );
  }
}

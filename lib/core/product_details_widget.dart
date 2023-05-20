import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:oonzoo_app/core/app_router.dart';
import 'package:oonzoo_app/core/formatters.dart';
import 'package:oonzoo_app/models/product.dart';
import 'package:oonzoo_app/viewmodels/cart_viewmodel.dart';
import 'package:oonzoo_app/views/cart_view.dart';
import 'package:provider/provider.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  late final PageController _pageController;
  int _currentPage = 2;
  String _selelctedSize = "3-6 M";

  final listOfSizes = [
    "3-6 M",
    "6-9 M",
    "9-12 M",
    "12-18 M",
    "18-24 M",
    "18-24 M",
    "2-3 Y",
    "3-4 Y",
    "4-5 Y",
  ];

  void updateSelectedSize(String option) {
    setState(() {
      _selelctedSize = option;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.68,
      initialPage: 1,
    );
    _pageController.addListener(() {
      setState(() {
        _currentPage = (((_pageController.page)?.toInt()) ?? 1) + 1;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 360,
          child: Stack(
            children: [
              BannerCarousel(
                animation: true,
                height: 360,
                pageController: _pageController,
                margin: EdgeInsets.zero,
                showIndicator: false,
                activeColor: Colors.amberAccent,
                disableColor: Colors.white,
                customizedIndicators: const IndicatorModel.animation(
                  width: 20,
                  height: 5,
                  spaceBetween: 2,
                  widthAnimation: 50,
                ),
                indicatorBottom: true,
                customizedBanners: [
                  for (final image in widget.product.image)
                    Image.network(
                      image,
                      fit: BoxFit.cover,
                    )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                          );
                        },
                        icon: const Icon(Icons.navigate_before),
                      ),
                      IconButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                          );
                        },
                        icon: const Icon(Icons.navigate_next),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    "$_currentPage/${widget.product.image.length}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '\$ ${Formatter.getDiscountedamount(widget.product.price, widget.product.discount.toDouble())}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'MRP: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '\$${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${(widget.product.discount * 100).toInt()}% OFF",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                "MRP incl. of all taxes",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "SIZE",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: listOfSizes.length,
                  separatorBuilder: (_, __) {
                    return const SizedBox(width: 16);
                  },
                  itemBuilder: (context, index) {
                    final size = listOfSizes[index];
                    final selectedIsCurrent = _selelctedSize == size;

                    return GestureDetector(
                      onTap: () {
                        updateSelectedSize(size);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: selectedIsCurrent
                              ? Border.all(color: Colors.orange)
                              : Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            size,
                            style: TextStyle(
                              color: selectedIsCurrent
                                  ? Colors.orange
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text(
                        "BRAND INFORMATION: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.product.brand,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 18,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "PRODUCT INFORMATION",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(widget.product.description),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: OutlinedButton(
            onPressed: () {
              context
                  .read<CartViewModel>()
                  .addProduct(widget.product, _selelctedSize);
              AppRouter.navigateTo(CartView.routeName);
            },
            child: const Text("BUY NOW"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextButton(
            onPressed: () {
              context
                  .read<CartViewModel>()
                  .addProduct(widget.product, _selelctedSize);
            },
            child: const Text("ADD TO CART"),
          ),
        ),
      ],
    );
  }
}

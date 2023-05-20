import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oonzoo_app/models/product.dart';

class ProductService {
  final _collection = FirebaseFirestore.instance.collection('products');

  Future<List<Product>> getAllProducts() async {
    return (await _collection.get())
        .docs
        .map((doc) => Product.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<Product> getProductById(String id) async {
    final doc = await _collection.doc(id).get();
    final res = Product.fromJson(doc.data()!, doc.id);

    return res;
  }
}

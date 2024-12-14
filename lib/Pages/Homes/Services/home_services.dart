import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/product_model.dart';

class HomeServices {
  Future<List<Product>> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsString = prefs.getString('products');
    if (productsString != null) {
      return (jsonDecode(productsString) as List)
          .map((item) => Product.fromJson(item))
          .toList();
    }
    return [];
  }

  Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('products', jsonEncode(products));
  }

  List<Product> searchProducts(String query, List<Product> productList) {
    return productList
        .where((product) =>
        product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<Product> deleteProduct(int index, List<Product> productList) {
    productList.removeAt(index);
    return List.from(productList);
  }
}


// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/

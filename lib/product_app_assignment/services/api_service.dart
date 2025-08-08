

import 'dart:convert';

import '../model/product_model.dart';
import 'package:http/http.dart' as http;

class APIservice {


  Future<List<Product>> fetchProducts() async {
    var url = Uri.parse('https://fakestoreapi.com/products');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<Product> products = [];
      for (var item in body) {
        products.add(Product.fromJson(item));
      }
      return products;
    } else {
      throw 'Failed to load products';
    }
  }
}

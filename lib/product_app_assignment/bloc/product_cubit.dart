

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systemic_altruism_/product_app_assignment/services/api_service.dart';

import '../model/product_model.dart';

part 'product_state.dart';

class ProductBloc extends Cubit<ProductState> {
  ProductBloc() : super(ProductInitial());

  void searchProducts(String query, List<Product> p) async {
    List<Product> products = [];
    emit(ProductLoading());
    try {
      p.map((product) {
        if (product.title.toLowerCase().contains(query.toLowerCase())) {
          products.add(product);
        }
      }).toList();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError());
    }
  }

  void getProducts() async {
    emit(ProductLoading());
    try {
      final products = await APIservice().fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError());
    }
  }
}
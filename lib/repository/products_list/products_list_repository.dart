import 'dart:convert';

import 'package:flutter_mvvm_provider/models/product/product_model.dart';
import 'package:flutter_mvvm_provider/services/api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class ProductsRepository {
  final ApiService _apiService = GetIt.instance<ApiService>();
  Future<List<Product>> getProducts() async {
    final Response response = await _apiService.get('/products', {});
    if (response.isSuccess) {
      final List<Product> productList =
          Product.listFromJson(response.data['products']);
      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    final Response response =
        await _apiService.get('/products/search?q=$query', {});
    if (response.isSuccess) {
      final List<Product> productList =
          Product.listFromJson(response.data['products']);
      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  }
}

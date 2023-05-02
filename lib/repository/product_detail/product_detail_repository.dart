import 'package:flutter_mvvm_provider/models/product/product_model.dart';
import 'package:flutter_mvvm_provider/services/api_service.dart';
import 'package:get_it/get_it.dart';

class ProductDetailRepository {
  final ApiService _apiService = GetIt.instance<ApiService>();
  Future<Product> getProduct(int id) async {
    final Response response = await _apiService.get('/products/$id', {});
    if (response.isSuccess) {
      final Product productList = Product.fromJson(response.data);
      return productList;
    } else {
      throw Exception('Failed to load product');
    }
  }
}

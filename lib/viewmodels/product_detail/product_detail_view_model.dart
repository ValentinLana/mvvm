import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/models/product/product_model.dart';
import 'package:flutter_mvvm_provider/repository/product_detail/product_detail_repository.dart';

class ProductDetailViewModel extends ChangeNotifier {
  ProductDetailViewModel(int productId) {
    getProduct(productId);
  }
  final ProductDetailRepository _productDetailRepository =
      ProductDetailRepository();

  bool _isLoading = false;
  late Product _product;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Product get product => _product;

  Future<void> getProduct(int productId) async {
    isLoading = true;
    try {
      final result = await _productDetailRepository.getProduct(productId);
      _product = result;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_provider/models/product/product_model.dart';
import 'package:flutter_mvvm_provider/repository/products_list/products_list_repository.dart';

class ProductsViewModel extends ChangeNotifier {
  ProductsViewModel() {
    loadProducts();
  }
  final ProductsRepository _repository = ProductsRepository();

  List<Product> _products = [];
  String _query = '';
  List<Product> get products => _products;
  String get query => _query;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final products = await _repository.getProducts();
      _products = products;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) async {
    _isLoading = true;
    _query = query;
    notifyListeners();
    try {
      final products = await _repository.searchProducts(query);
      _products = products;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/view/login/login_screen.dart';
import 'package:flutter_mvvm_provider/view/products_list/widgets/products_list.dart';
import 'package:flutter_mvvm_provider/viewmodels/products_list/product_list_view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsViewModel(),
      builder: (context, child) {
        final productsViewModel = Provider.of<ProductsViewModel>(context);
        final controller = TextEditingController();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter challenge 2023'),
            actions: [
              IconButton(
                  onPressed: () async {
                    const secureStorage = FlutterSecureStorage();

                    await secureStorage.delete(key: 'token');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          labelText: 'Buscar productos',
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          productsViewModel.searchProducts(controller.text);
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
              ),
              if (!productsViewModel.isLoading)
                Expanded(
                  child: ProductList(
                    products: productsViewModel.products,
                    query: productsViewModel.query,
                  ),
                ),
              if (productsViewModel.isLoading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator())),
            ],
          ),
        );
      },
    );
  }
}

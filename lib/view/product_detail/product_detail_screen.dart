import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/viewmodels/product_detail/product_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;
  final String productTitle;

  ProductDetailScreen({
    Key? key,
    required this.productId,
    required this.productTitle,
  }) : super(key: key);

  final NumberFormat formatter = NumberFormat.currency(
    locale: 'es_ES',
    symbol: 'USD',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductDetailViewModel(productId),
      builder: (context, child) {
        final viewModel = Provider.of<ProductDetailViewModel>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(productTitle),
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: viewModel.product.images.length,
                                itemBuilder: (context, index) {
                                  final imageUrl =
                                      viewModel.product.images[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.network(imageUrl),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(viewModel.product.description),
                            const SizedBox(height: 45),
                            Text(
                              formatter.format(viewModel.product.price),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Agregar al carrito'),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

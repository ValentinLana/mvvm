import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/models/product/product_model.dart';
import 'package:flutter_mvvm_provider/view/product_detail/product_detail_screen.dart';
import 'package:intl/intl.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final String query;

  ProductList({Key? key, required this.products, required this.query})
      : super(key: key);

  final NumberFormat formatter = NumberFormat.currency(
    locale: 'es_ES',
    symbol: 'USD',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: Text(
            'No se encontraron resultados ${query.isNotEmpty ? 'para $query' : ''}'),
      );
    }

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        return InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      formatter.format(product.price),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  product.brand,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Text(product.description),
                const SizedBox(height: 20),
                Text('Stock: ${product.stock}')
              ],
            ),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                productId: product.id,
                productTitle: product.title,
              ),
            ),
          ),
        );
      },
    );
  }
}

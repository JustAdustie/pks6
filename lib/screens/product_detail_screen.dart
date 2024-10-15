import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  ProductDetailScreen({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                product.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(product.description, style: TextStyle(fontSize: 16)),
            ),
            Text('\$${product.price}', style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: onAddToCart,
              child: Text('Добавить в корзину'),
            ),
          ],
        ),
      ),
    );
  }
}

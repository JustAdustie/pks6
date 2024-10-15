import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Product> favoriteProducts;
  final Function(Product) onRemove;

  FavoriteScreen({required this.favoriteProducts, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      body: favoriteProducts.isEmpty
          ? Center(child: Text('Избранных товаров нет'))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    favoriteProducts[index].imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    favoriteProducts[index].name,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    onRemove(favoriteProducts[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

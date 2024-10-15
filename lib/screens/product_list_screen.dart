import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import 'product_detail_screen.dart';
import 'favorite_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  List<Product> favoriteProducts = [];
  List<CartItem> cartItems = [];

  void addToCart(Product product) {
    setState(() {
      CartItem existingItem = cartItems.firstWhere(
            (item) => item.product.name == product.name,
        orElse: () => CartItem(product: product, quantity: 0),
      );

      if (existingItem.quantity > 0) {
        existingItem.quantity++;
      } else {
        cartItems.add(CartItem(product: product, quantity: 1));
      }
    });
  }

  void removeFromCart(CartItem cartItem) {
    setState(() {
      cartItems.remove(cartItem);
    });
  }

  void addProduct(String name, String description, String imagePath, double price) {
    setState(() {
      products.add(Product(name, imagePath, description, price));
    });
  }

  void showAddProductDialog() {
    String name = '';
    String description = '';
    String imagePath = '';
    double price = 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Добавить товар'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Название'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Описание'),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.tryParse(value) ?? 0.0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (name.isNotEmpty && description.isNotEmpty && price > 0) {
                  addProduct(name, description, imagePath, price);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Добавить'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Отмена'),
            ),
          ],
        );
      },
    );
  }

  void deleteProduct(Product product) {
    setState(() {
      products.remove(product);
    });
  }

  void showDeleteProductDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Удалить товар'),
          content: Text('Вы уверены, что хотите удалить этот товар?'),
          actions: [
            TextButton(
              onPressed: () {
                deleteProduct(product);
                Navigator.of(context).pop();
              },
              child: Text('Да'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Нет'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Магазин машинок'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: showAddProductDialog,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    product: products[index],
                    onAddToCart: () => addToCart(products[index]),
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      products[index].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(products[index].name, style: TextStyle(fontSize: 16)),
                  ),
                  Text('\$${products[index].price}', style: TextStyle(fontSize: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          favoriteProducts.contains(products[index])
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favoriteProducts.contains(products[index])
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            if (favoriteProducts.contains(products[index])) {
                              favoriteProducts.remove(products[index]);
                            } else {
                              favoriteProducts.add(products[index]);
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDeleteProductDialog(products[index]);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoriteScreen(
                  favoriteProducts: favoriteProducts,
                  onRemove: (product) {
                    setState(() {
                      favoriteProducts.remove(product);
                    });
                  },
                ),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(
                  cartItems: cartItems,
                  onRemove: removeFromCart,
                ),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}

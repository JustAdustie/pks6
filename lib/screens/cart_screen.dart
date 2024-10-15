import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(CartItem) onRemove;

  CartScreen({required this.cartItems, required this.onRemove});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double getTotalAmount() {
    return widget.cartItems.fold(0.0, (total, item) => total + item.product.price * item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      body: widget.cartItems.isEmpty
          ? Center(child: Text('Корзина пуста'))
          : ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.cartItems[index].product.name),
            subtitle: Text('Цена: \$${widget.cartItems[index].product.price}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (widget.cartItems[index].quantity > 1) {
                        widget.cartItems[index].quantity--;
                      } else {
                        widget.onRemove(widget.cartItems[index]);
                      }
                    });
                  },
                ),
                Text('${widget.cartItems[index].quantity}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      widget.cartItems[index].quantity++;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Удалить товар'),
                          content: Text('Вы уверены, что хотите удалить этот товар?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                widget.onRemove(widget.cartItems[index]);
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
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Text('Итого: \$${getTotalAmount().toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

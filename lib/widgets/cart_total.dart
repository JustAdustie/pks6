import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartTotal extends StatelessWidget {
  final List<CartItem> cartItems;

  CartTotal({required this.cartItems});

  double getTotalAmount() {
    return cartItems.fold(0.0, (total, item) => total + item.product.price * item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        'Итого: \$${getTotalAmount().toStringAsFixed(2)}',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

import 'package:bee_kahve/screens/products/product_details.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<Coffee, int> _cartItems = {};

  Map<Coffee, int> get cartItems => _cartItems;

  void addToCart(Coffee product) {
    if (_cartItems.containsKey(product)) {
      _cartItems.update(product, (value) => value + 1);
    } else {
      _cartItems.putIfAbsent(product, () => 1);
    }
    notifyListeners();
  }

  void removeFromCart(Coffee product) {
    _cartItems.update(product, (value) => value - 1);
    if (_cartItems[product] == 0) {
      _cartItems.remove(product);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
  // Add other methods as needed

  // Singleton pattern
  static final CartProvider _instance = CartProvider._internal();

  factory CartProvider() {
    return _instance;
  }

  CartProvider._internal();
}

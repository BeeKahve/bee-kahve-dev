import 'package:bee_kahve/screens/products/product_details.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Coffee> _cartItems = [];

  List<Coffee> get cartItems => _cartItems;

  void addToCart(Coffee product, {int quantity = 1}) {
    // You can implement logic to handle duplicate items or update quantities here
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Coffee product) {
    _cartItems.removeWhere((thisProduct) => thisProduct == product);
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

import 'package:bee_kahve/models/line_items_model.dart';

class Order {
  final int customerID;
  final int? orderID;
  final List<Coffee> lineItems;
  final String? orderDate;
  final String? orderStatus;

  Order(
      {required this.customerID,
      this.orderID,
      required this.lineItems,
      this.orderDate,
      this.orderStatus});

  Map<Coffee, int> listToMap() {
    Map<Coffee, int> productWithCounts = {};
    for (Coffee item in lineItems) {
      if (productWithCounts.containsKey(item)) {
        productWithCounts.update(item, (value) => value + 1);
      } else {
        productWithCounts.putIfAbsent(item, () => 1);
      }
    }
    return productWithCounts;
  }
}

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
}

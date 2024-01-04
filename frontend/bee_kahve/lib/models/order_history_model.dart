import 'package:bee_kahve/models/past_order_model.dart';

class OrderHistory {
  final String? customerName;
  final List<Order> orders;
  final int? orderCount;

  OrderHistory({this.customerName, required this.orders, this.orderCount});
}

import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/line_items_model.dart';
import 'package:bee_kahve/models/past_order_model.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:bee_kahve/root.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:bee_kahve/screens/profile/rate.dart';

class OrderDetailsScreen extends StatefulWidget {
  final User? user;
  final Order order;
  const OrderDetailsScreen({Key? key, required this.order, required this.user})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

const Map<String, List<dynamic>> processes = {
  "waiting": [0, "Placed"],
  "preparing": [1, "Preparing"],
  "on_the_way": [2, "On the way"],
  "delivered": [3, "Delivered"],
  "cancelled": [4, "Cancelled"],
};

const Map<String, String> milkTypes = {
  "whole_milk": "Whole Milk",
  "reduced_fat_milk": "Reduced Fat Milk",
  "lactose_free_milk": "Lactose Free Milk",
  "oat_milk": "Oat Milk",
  "almond_milk": "Almond Milk",
};

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Order order;
  Color colorChoice = Colors.green;
  @override
  void initState() {
    order = widget.order;
    if (processes[order.orderStatus]![0] == 4) {
      colorChoice = Colors.red;
    }
    super.initState();
  }

  String calculateTotalPrice(Order order) {
    double total = 0;
    for (Coffee product in order.lineItems) {
      total += product.price;
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 32),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RootScreen(currentScreen: 2, user: widget.user)));
            },
          ),
          title: Text(
            "Order ${order.orderID}",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: AppColors.textColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (processes[order.orderStatus]![0] == 4)
                  const Text(
                    "Order Cancelled",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                Container(
                  height: 120,
                  alignment: Alignment.topCenter,
                  child: Timeline.tileBuilder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    theme: TimelineThemeData(
                      direction: Axis.horizontal,
                      connectorTheme:
                          const ConnectorThemeData(space: 8.0, thickness: 2.0),
                    ),
                    builder: TimelineTileBuilder.connected(
                      connectionDirection: ConnectionDirection.before,
                      itemCount: 4,
                      itemExtentBuilder: (_, __) {
                        return (MediaQuery.of(context).size.width - 80) / 4.0;
                      },
                      oppositeContentsBuilder: (context, index) {
                        return Container();
                      },
                      contentsBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            processes.values.toList()[index][1],
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      },
                      indicatorBuilder: (_, index) {
                        if (processes[order.orderStatus]![0] == 5) {}
                        if (index <= processes[order.orderStatus]![0]) {
                          return DotIndicator(
                            size: 15.0,
                            color: colorChoice,
                          );
                        } else {
                          return OutlinedDotIndicator(
                            borderWidth: 4.0,
                            color: colorChoice,
                          );
                        }
                      },
                      connectorBuilder: (_, index, type) {
                        if (index > 0) {
                          return SolidLineConnector(
                            color: colorChoice,
                          );
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    children: [
                      for (Coffee product in order.listToMap().keys.toList())
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CachedNetworkImage(
                                imageUrl: product.photoPath,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                width: 90,
                                height: 90,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product.name} ${product.sizeChoice}",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (product.milkChoice != null)
                                    Text(
                                      "- ${milkTypes[product.milkChoice]}",
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  if (product.caffeineChoice == true)
                                    const Text(
                                      "- Decaf",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  if (product.extraShotChoice == true)
                                    const Text(
                                      "- Extra Shot",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${order.listToMap()[product]} x ${product.price}\₺",
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RatePage(
                                                          product: product,
                                                          user: widget.user)));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.yellow,
                                        ),
                                        child: const Text(
                                          "Rate",
                                          style: TextStyle(
                                              color: AppColors.darkColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${calculateTotalPrice(order)}\₺",
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

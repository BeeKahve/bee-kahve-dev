import 'package:bee_kahve/consts/app_color.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:bee_kahve/screens/profile/rate.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

const List<String> processes = [
  "Placed",
  "Preparing",
  "On the way",
  "Delivered"
];

const int currentStatus = 2;

class PastOrder {
  final String id;
  final String time;
  final List<String> names;
  final List<String> images;
  final List<int> count;
  final List<double> prices;
  final double cost;

  const PastOrder({
    required this.id,
    required this.time,
    required this.names,
    required this.images,
    required this.count,
    required this.prices,
    required this.cost,
  });
}

PastOrder pastOrder1 = const PastOrder(
  id: "123456",
  time: "12:30 PM",
  names: ["Cappuccino", "Cappuccino", "Cappuccino", "Latte", "Espresso"],
  images: [
    "assets/images/cappuccino.jpg",
    "assets/images/cappuccino.jpg",
    "assets/images/cappuccino.jpg",
    "assets/images/cappuccino.jpg",
    "assets/images/cappuccino.jpg"
  ],
  count: [1, 1, 1, 1, 1],
  prices: [4.5, 4.5, 4.5, 5.0, 3.0],
  cost: 21.5,
);

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool? isChecked = false;
  bool? isCheckedDecaf = false;
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
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Order ID",
            style: TextStyle(
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
                            processes[index],
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      },
                      indicatorBuilder: (_, index) {
                        if (index <= currentStatus) {
                          return const DotIndicator(
                            size: 15.0,
                            color: Colors.green,
                          );
                        } else {
                          return OutlinedDotIndicator(
                            borderWidth: 4.0,
                            color: Colors.green,
                          );
                        }
                      },
                      connectorBuilder: (_, index, type) {
                        if (index > 0) {
                          return const SolidLineConnector(
                            color: Colors.green,
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
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < pastOrder1.names.length; i++)
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                pastOrder1.images[i],
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  children: [
                                    Text(
                                      "${pastOrder1.names[i]}  ${pastOrder1.count[i]} x ${pastOrder1.prices[i]}\$",
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RatePage()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.yellow,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 40.0,
                                          vertical: 10.0,
                                        ),
                                      ),
                                      child: const Text(
                                        "Rate",
                                        style: TextStyle(
                                            color: AppColors.darkColor),
                                      ),
                                    ),
                                  ],
                                ),
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
                          "${pastOrder1.cost}\$",
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

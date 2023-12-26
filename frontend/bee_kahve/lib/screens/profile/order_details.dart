import 'package:bee_kahve/consts/app_color.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

const List<String> _processes = ["Placed", "Preparing", "On the way", "Delivered"];

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool? isChecked = false;
  bool? isCheckedDecaf = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if(Navigator.canPop(context)){
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.keyboard_backspace, size: 32,),
                    ),
                    const Text("Order ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: AppColors.textColor),)
                  ],
                ),
                Container(
                  height: 120,
                  alignment: Alignment.topCenter,
                  child: Timeline.tileBuilder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    theme: TimelineThemeData(
                      direction: Axis.horizontal,
                      connectorTheme: const ConnectorThemeData(space: 8.0, thickness: 2.0),
                    ),
                    builder: TimelineTileBuilder.connected(
                      connectionDirection: ConnectionDirection.before,
                      itemCount: 4,
                      itemExtentBuilder: (_, __) {
                        return (MediaQuery.of(context).size.width - 120) / 4.0;
                      },
                      oppositeContentsBuilder: (context, index) {
                        return Container();
                      },
                      contentsBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            _processes[index],
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                      indicatorBuilder: (_, index) {

                        if (index <= 5) {
                          return const DotIndicator(
                            size: 30.0,
                            color: Colors.green,
                          );
                        } else {
                          return const OutlinedDotIndicator(
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
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side: Order details
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/cappuccino.jpg",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Cappuccino",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      // Right side: View Order button
                      ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                        ),
                        child: const Text(
                          "Rate Product",
                          style: TextStyle(color: AppColors.darkColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side: Order details
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/cappuccino.jpg",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "order.name",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      // Right side: View Order button
                      ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                        ),
                        child: const Text(
                          "Rate Product",
                          style: TextStyle(color: AppColors.darkColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

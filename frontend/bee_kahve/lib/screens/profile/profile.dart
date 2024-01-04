import 'dart:convert';
import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/line_items_model.dart';
import 'package:bee_kahve/models/order_history_model.dart';
import 'package:bee_kahve/models/past_order_model.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:bee_kahve/screens/auth/signin.dart';
import 'package:bee_kahve/screens/profile/order_details.dart';
import 'package:bee_kahve/screens/profile/update_address.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final User? user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late OrderHistory orderHistory;
  @override
  void initState() {
    super.initState();
    orderHistory = OrderHistory(orders: []);
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      var response = await http.get(Uri.parse(
          'http://51.20.117.162:8000/order_history?customer_id=${widget.user!.customerId}'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<Order> orders = [];
        if (jsonData['orders'] is List) {
          orders = List<Order>.from(jsonData['orders'].map((item) => Order(
                customerID: item['customer_id'],
                orderID: item['order_id'],
                lineItems:
                    List<Coffee>.from(item['line_items'].map((i) => Coffee(
                          id: i['product_id'],
                          name: i['name'],
                          photoPath: i['photo_path'],
                          price: i['price'],
                          sizeChoice: i['size_choice'],
                          milkChoice: i['milk_choice'],
                          extraShotChoice: i['extra_shot_choice'],
                          caffeineChoice: i['caffein_choice'],
                        ))),
                orderDate: item['order_date'],
                orderStatus: item['order_status'],
              )));
        }
        OrderHistory history = OrderHistory(orders: orders);

        setState(() {
          orderHistory = history;
        });
      } else {
        print('Failed to load order history data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order history data: $e');
    }
  }

  @override
  void dispose() {
    if (mounted) {
      super.dispose();
    }
  }

  String calculateTotalPrice(Order order) {
    double total = 0;
    for (Coffee product in order.lineItems) {
      total += product.price;
    }
    return total.toStringAsFixed(2);
  }

  String timeOfOrder(String dateTime) {
    List<String> dateList = dateTime.substring(0, 10).split('-');
    List<String> timeList = dateTime.substring(11, 19).split(':');
    String formattedDate = '${dateList[2]}/${dateList[1]}/${dateList[0]}';
    String formattedTime = '${timeList[0]}:${timeList[1]}';
    return "$formattedDate $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Row(
            children: [
              Text(
                "Bee' ",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.yellow),
              ),
              Text(
                "Kahve",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.user?.name ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.user?.email ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user?.address ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          backgroundColor: AppColors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateAddressScreen(user: widget.user)));
                        },
                        child: const Text(
                          "Update Address",
                          style: TextStyle(color: AppColors.darkColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Order History",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  itemCount: orderHistory.orders.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: AppColors.yellow,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order ID: ${orderHistory.orders[orderHistory.orders.length - 1 - index].orderID}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                      timeOfOrder(orderHistory
                                          .orders[orderHistory.orders.length -
                                              1 -
                                              index]
                                          .orderDate!),
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              for (Coffee lineItem in orderHistory.orders[
                                      orderHistory.orders.length - 1 - index]
                                  .listToMap()
                                  .keys
                                  .toList())
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: lineItem.photoPath,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        width: 90.0,
                                        height: 90.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(lineItem.name),
                                          Text(
                                            "${orderHistory.orders[orderHistory.orders.length - 1 - index].listToMap()[lineItem]} x ${lineItem.price.toStringAsFixed(2)}\$",
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${calculateTotalPrice(orderHistory.orders[orderHistory.orders.length - 1 - index])}₺",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderDetailsScreen(
                                                      order: orderHistory
                                                          .orders[orderHistory
                                                              .orders.length -
                                                          1 -
                                                          index],
                                                      user: widget.user)));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.yellow,
                                    ),
                                    child: const Text(
                                      "View Order",
                                      style:
                                          TextStyle(color: AppColors.darkColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    // return Center(
                    //   child: Text(
                    //     pastOrders[index].name,
                    //     style: Theme.of(context).textTheme.headlineSmall,
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

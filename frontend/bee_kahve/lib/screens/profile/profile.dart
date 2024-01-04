import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/models/order_history_model.dart';
import 'package:bee_kahve/models/user_model.dart';
import 'package:bee_kahve/screens/profile/update_address.dart';
import 'package:flutter/material.dart';
import 'package:bee_kahve/screens/profile/order_details.dart';

class Order {
  final int id;
  final String time;
  final double cost;
  final List<int> count;
  final List<double> prices;
  final List<String> names;
  final List<String> images;

  Order(this.id, this.time, this.cost, this.count, this.prices, this.names,
      this.images);
}

List<Order> pastOrders = [
  Order(
    1,
    "12.12.23",
    22.50,
    [1, 2],
    [10.50, 6.00],
    ["Cappuccino", "BASKET OFC"],
    ["assets/images/cappuccino.jpg", "assets/images/basket.png"],
  ),
  Order(2, "14.12.23", 22.00, [
    1,
    1,
    1
  ], [
    6.00,
    12.00,
    4.00
  ], [
    "BASKET OFC",
    "Cappuccino",
    "LOGO LOL"
  ], [
    "assets/images/cappuccino.jpg",
    "assets/images/basket.png",
    "assets/images/bee-logo.png"
  ]),
  Order(3, "15.12.23", 10.50, [1], [6.0], ["BASKET OFC"],
      ["assets/images/basket.png"]),
];

// class OrderHistoryItem extends StatelessWidget {
//   final Order order;
//
//   const OrderHistoryItem({Key? key, required this.order}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       width: double.infinity,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Left side: Order details
//           Row(
//             children: [
//               Image.asset(
//                 order.image,
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 order.name,
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           // Right side: View Order button
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetailsScreen()));
//             },
//             style: ElevatedButton.styleFrom(
//               primary: AppColors.yellow,
//             ),
//             child: const Text(
//               "View Order",
//               style: TextStyle(color: AppColors.darkColor),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
  }

  @override
  void dispose() {
    if (mounted) {
      super.dispose();
    }
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
                // DynamicHeightGridView(
                //     mainAxisSpacing: 12,
                //     crossAxisSpacing: 12,
                //     shrinkWrap: true,
                //     physics: const BouncingScrollPhysics(),
                //     builder: (context, index){
                //       return const Text("AAA");
                //     },  itemCount: 200,
                //     crossAxisCount: 1
                // ),
                ListView.builder(
                  itemCount: pastOrders.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 40.0,
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
                                    "Order ID: ${pastOrders[index].id}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(pastOrders[index].time,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              for (int i = 0;
                                  i < pastOrders[index].count.length;
                                  i++)
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
                                      Image.asset(
                                        pastOrders[index].images[i],
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        "${pastOrders[index].names[i]}  ${pastOrders[index].count[i]} x ${pastOrders[index].prices[i]}\$",
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
                                    "${pastOrders[index].cost}\$",
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

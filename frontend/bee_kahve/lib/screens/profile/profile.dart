import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/screens/profile/update_address.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:bee_kahve/screens/profile/order_details.dart';


class Order {
  final String name;
  final String image;

  Order(this.name, this.image);
}

List<Order> pastOrders = [
  Order("Order 1", "assets/images/cappuccino.jpg"),
  Order("Order 2", "assets/images/cappuccino.jpg"),
  Order("Order 3", "assets/images/cappuccino.jpg"),
];

class OrderHistoryItem extends StatelessWidget {
  final Order order;

  const OrderHistoryItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: Order details
          Row(
            children: [
              Image.asset(
                order.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Text(
                order.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          // Right side: View Order button
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetailsScreen()));
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.yellow,
            ),
            child: const Text(
              "View Order",
              style: TextStyle(color: AppColors.darkColor),
            ),
          ),
        ],
      ),
    );
  }
}


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState(){
    super.initState();
  }
  @override
  void dispose(){
    if(mounted){
      super.dispose();
    }
  }

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
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50,),
                  const Row(
                    children: [
                       Text(
                        "Bee'",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.yellow),
                      ),
                      Text(
                        "Kahve",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor, ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "test@gmail.com",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor, ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Address",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor, ),
                  ),

                  const SizedBox(height: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        " İTÜ Ayazağa Kampüsü, Rektörlük Binası, 34467 Maslak-İSTANBUL",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textColor, ),
                      ),
                      const SizedBox(height: 20,),
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
                                context, MaterialPageRoute(builder: (context) => const UpdateAddressScreen()));
                          },
                          child: const Text("Update Address", style: TextStyle(color: AppColors.darkColor),),

                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        "Order History",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor,),
                      ),
                      OrderHistoryItem(order: pastOrders[0]),
                      OrderHistoryItem(order: pastOrders[1]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


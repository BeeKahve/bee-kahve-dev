import 'dart:developer';
import 'package:bee_kahve/consts/app_color.dart';
import 'package:bee_kahve/screens/profile/update_address.dart';
import 'package:bee_kahve/widgets/products/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchTextController;
  @override
  void initState(){
    searchTextController = TextEditingController();
    super.initState();
  }
  @override
  void dispose(){
    if(mounted){
      searchTextController.dispose();
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
                  TextField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.lightYellow,
                        hintText: "Search coffee",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              searchTextController.clear();
                              FocusScope.of(context).unfocus();
                            });
                          },
                            child: const Icon(Icons.clear)),
                        contentPadding: const EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(color: AppColors.lightYellow, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(color: AppColors.lightYellow, width: 2),
                        ),
                    ),
                    onSubmitted: (value){
                      log("value of the controller text: ${searchTextController.text}");
                    },
                  ),
                  const SizedBox(height: 15,),
                  const Text("Campaigns", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: AppColors.textColor),),
                  const SizedBox(height: 15,),
                  const Center(
                      child: Text("3 coffees left to get a reward drink", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: AppColors.textColor),)),
                  const SizedBox(height: 15,),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.coffee, size: 40, color: AppColors.yellow,),
                        Icon(Icons.coffee, size: 40, color: AppColors.yellow,),
                        Icon(Icons.coffee, size: 40,),
                        Icon(Icons.coffee, size: 40,),
                        Icon(Icons.coffee, size: 40,),
                      ],
                    ),
                  const SizedBox(height: 15,),
                  const Text("Coffee Menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: AppColors.textColor),),
                  Expanded(
                    child: DynamicHeightGridView(
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        builder: (context, index){
                      return const ProductWidget();
                    },  itemCount: 200,
                        crossAxisCount: 2),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
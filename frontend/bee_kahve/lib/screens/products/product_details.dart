import 'package:bee_kahve/consts/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool? isChecked = false;
  bool? isCheckedDecaf = false;
  String? _dropdownValue = "Milk Options";
  void dropdownCallBack(String? selectedValue) {
    if(selectedValue is String){
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }
  Future<void> _add_to_cart()async{
    FocusScope.of(context).unfocus();
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
                      const Text("Coffee Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: AppColors.textColor),)
                    ],
                  ),
                const SizedBox(height: 20,),
                Image.asset('assets/images/cappuccino.jpg', height: 200, width: double.infinity, ),
                const SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Ratings", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.textColor),),
                      ),
                      Icon(Icons.star_border),
                      Icon(Icons.star_border),
                      Icon(Icons.star_border),
                      Icon(Icons.star_border),
                      Icon(Icons.star_border),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Extra shot", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.textColor),),
                    Checkbox(
                        value: isChecked,
                        activeColor: AppColors.yellow,
                        onChanged: (newBool){
                          setState(() {
                            isChecked = newBool;
                          });
                    }),
                    const Text("Decaf", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.textColor),),
                    Checkbox(
                        value: isCheckedDecaf,
                        activeColor: AppColors.yellow,
                        onChanged: (newBool){
                          setState(() {
                            isCheckedDecaf = newBool;
                          });
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: DropdownButton(
                    items: const [
                      DropdownMenuItem(value: "Milk Options", enabled: false, child: Text("Milk Options", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color: AppColors.textColor),)),
                      DropdownMenuItem(value: "Whole Milk", child: Text("Whole Milk", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color: AppColors.textColor),),),
                      DropdownMenuItem(value: "Reduced Fat Milk", child: Text("Reduced Fat Milk", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color: AppColors.textColor),),),
                      DropdownMenuItem(value: "Lactose Free Milk", child: Text("Lactose Free Milk", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color: AppColors.textColor),),),
                      DropdownMenuItem(value: "Oat Milk", child: Text("Oat Milk", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color: AppColors.textColor),),),
                      DropdownMenuItem(value: "Almond Milk", child: Text("Almond Milk", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color: AppColors.textColor),),),
                    ],
                    value: _dropdownValue,
                    onChanged: dropdownCallBack,
                    iconSize: 32,
                    isExpanded: true,
                  ),
                ),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(onPressed: () {},
                      child: const Text("Small\n\$4", style: TextStyle(color: AppColors.textColor),textAlign: TextAlign.center,),
                    ),
                    TextButton(onPressed: () {},
                      child: const Text("Medium\n\$5", style: TextStyle(color: AppColors.textColor),textAlign: TextAlign.center,),
                    ),
                    TextButton(onPressed: () {
                    },
                      child: const Text("Large\n\$7", style: TextStyle(color: AppColors.textColor),textAlign: TextAlign.center,),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: AppColors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () async {
                      await _add_to_cart();
                    },
                    child: const Text("Add to Cart", style: TextStyle(color: AppColors.darkColor),),
                  ),
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}

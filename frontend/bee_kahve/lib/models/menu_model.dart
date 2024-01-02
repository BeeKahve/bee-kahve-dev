import 'package:bee_kahve/models/menu_product_model.dart';

class MenuModel {
  final int productCount;
  List<MenuProductModel> menuProducts;

  MenuModel({
    required this.productCount,
    required this.menuProducts,
  });
}
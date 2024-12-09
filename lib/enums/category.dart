import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Category {
  Home,
  Travel,
  Gas,
  Food,
  Entertainment,
  Clothing,
  Daily,
  Groceries;

  static IconData getCategoryIcon(String category) {
    final Map<String, IconData> correspondingIcon = {
      Category.Home.name: Icons.home,
      Category.Travel.name: Icons.airplanemode_on_sharp,
      Category.Gas.name: Icons.local_gas_station,
      Category.Food.name: Icons.fastfood,
      Category.Entertainment.name: Icons.movie_creation_outlined,
      Category.Clothing.name: Icons.shopping_bag,
      Category.Groceries.name: Icons.local_grocery_store_outlined,
      Category.Daily.name: Icons.coffee
    };
    return correspondingIcon[category] ?? Icons.help_outline;
  }


  static Color getCategoryColor(String category){
    final Map<String, Color> correspondingColor={
      Category.Home.name: Color.fromRGBO(212, 190, 228,1),
      Category.Travel.name:Color.fromRGBO(254, 236, 55 ,1),
      Category.Gas.name:Color.fromRGBO(96, 139, 193,1),
      Category.Food.name:Color.fromRGBO(138, 191, 163,1),
      Category.Entertainment.name:Color.fromRGBO(255, 230, 165,1),
      Category.Clothing.name:Color.fromRGBO(255, 119, 183,1),
      Category.Groceries.name:Color.fromRGBO(255, 162, 76,1),
      Category.Daily.name:Color.fromRGBO(136,194, 115, 1),
    };
    return correspondingColor[category] ?? Color.fromRGBO(255, 191, 97,1);
  }
}
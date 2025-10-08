import 'package:e_commerece/common_widgets/common_colors.dart';
import 'package:e_commerece/pages/cart.dart';
import 'package:e_commerece/pages/products.dart';
import 'package:e_commerece/pages/profile.dart';
import 'package:flutter/material.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  List pages = [Products(), Cart(), Profile()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: white,
        currentIndex: index,
        onTap: (selectedindex) {
          setState(() {
            index = selectedindex;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_4_outlined),
            label: 'Profile',
          ),
        ],
        selectedItemColor: themeColor,
        unselectedItemColor: black,
      ),
    );
  }
}

import 'package:e_commerece/Services/dbservice.dart';
import 'package:e_commerece/common_widgets/common_colors.dart';
import 'package:e_commerece/common_widgets/textWidget.dart';
import 'package:e_commerece/Controllers/cartContoller.dart';
import 'package:e_commerece/Models/cartModel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late double height, width;
  DBService dbService = DBService();

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: textWidget(
          text: "My Cart",
          fontSize: height * 0.02,
          fontweight: FontWeight.w700,
          fontColor: black,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.loading.value) {
          return Center(child: CircularProgressIndicator(color: black));
        }
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: textWidget(
              text: "Your cart is empty!",
              fontSize: height * 0.018,
              fontweight: FontWeight.w500,
              fontColor: grey,
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return showItem(item);
                },
              ),
            ),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: white,
                boxShadow: [BoxShadow(blurRadius: 8, offset: Offset(0, -2))],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    text: "Subtotal",
                    fontSize: height * 0.02,
                    fontweight: FontWeight.w600,
                    fontColor: black,
                  ),
                  Obx(
                    () => textWidget(
                      text:
                          "₹ ${cartController.getSubtotal().toStringAsFixed(2)}",
                      fontSize: height * 0.022,
                      fontweight: FontWeight.w700,
                      fontColor: black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  showItem(CartItem item) {
    return Card(
      color: white,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(
              height: width * 0.2,
              width: width * 0.2,
              child: Image.asset('assets/${item.image}.png', fit: BoxFit.cover),
            ),
            SizedBox(width: width * 0.03),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: item.name,
                    fontSize: height * 0.02,
                    fontweight: FontWeight.w600,
                    fontColor: black,
                  ),
                  SizedBox(height: height * 0.01),
                  textWidget(
                    text: "₹ ${item.price.toStringAsFixed(2)}",
                    fontSize: height * 0.018,
                    fontweight: FontWeight.w500,
                    fontColor: black,
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          cartController.decrementQuantity(item);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: grey.withOpacity(0.2),
                          ),
                          child: Icon(Icons.remove, size: 20),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      textWidget(
                        text: item.quantity.toString(),
                        fontSize: height * 0.018,
                        fontweight: FontWeight.w500,
                        fontColor: black,
                      ),
                      SizedBox(width: width * 0.02),

                      InkWell(
                        onTap: () {
                          cartController.incrementQuantity(item);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: grey.withOpacity(0.2),
                          ),
                          child: Icon(Icons.add, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {
                cartController.removeFromCart(item);
              },
              icon: Icon(Icons.delete_outline, color: red),
            ),
          ],
        ),
      ),
    );
  }
}

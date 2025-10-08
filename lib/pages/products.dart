import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece/Services/dbservice.dart';
import 'package:e_commerece/common_widgets/common_colors.dart';
import 'package:e_commerece/common_widgets/textWidget.dart';
import 'package:e_commerece/common_widgets/textfield.dart';
import 'package:e_commerece/pages/productDetails.dart';
import 'package:e_commerece/Models/product_model.dart';
import 'package:e_commerece/Controllers/productsContoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late double height, width;
  TextEditingController search = TextEditingController();
  DBService dbService = DBService();
  List MyCart = [];

  final ProductController productController = Get.put(
    ProductController(),
    permanent: true,
  );

  getMyCart() async {
    QuerySnapshot querySnapshot = await dbService.getCartDetails();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    for (var i in documents) {
      MyCart.add(i.id);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: textWidget(
          text: "Aventa",
          fontSize: height * 0.02,
          fontweight: FontWeight.w700,
          fontColor: black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget(
              text: "Aventa : simple,\nclassy, memorable",
              fontSize: height * 0.027,
              fontweight: FontWeight.w700,
              fontColor: black,
            ),
            SizedBox(height: height * 0.02),
            textfieldWidget(
              hintText: "Search products",
              controller: search,
              hintColor: grey,
              prefixIcon: Icon(Icons.search, color: grey),

              hintSize: height * 0.017,
            ),

            SizedBox(height: height * 0.02),
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value) {
                  return Center(child: CircularProgressIndicator(color: black));
                }
                if (productController.categories.isEmpty) {
                  return Center(
                    child: textWidget(
                      text: "No products available",
                      fontSize: height * 0.018,
                      fontweight: FontWeight.w500,
                      fontColor: grey,
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: productController.categories.length,
                  itemBuilder: (context, index) {
                    final productCategory = productController.categories[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),

                      child: category(productCategory),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget category(String productCategory) {
    final products = productController.getProductsByCategory(productCategory);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(
          text: productCategory,
          fontSize: height * 0.02,
          fontweight: FontWeight.w900,
          fontColor: black,
        ),
        SizedBox(height: height * 0.012),
        SizedBox(
          height: height * 0.3,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final productData = products[index];
              return product(productData);
            },
          ),
        ),
      ],
    );
  }

  Widget product(Product productData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              reverseTransitionDuration: Duration(milliseconds: 200),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ProductDetails(
                    product: productData,
                    isInMyCart: MyCart.contains(productData.docId),
                  ),
            ),
          );
        },
        child: Hero(
          tag: productData.docId,
          child: SizedBox(
            width: width * 0.45,
            child: Card(
              color: white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.15,
                      width: width * 0.3,
                      child: Image.asset(
                        'assets/${productData.image}.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: height * 0.006),
                    textWidget(
                      text: productData.name,
                      overflow: TextOverflow.ellipsis,
                      fontSize: height * 0.015,
                      fontweight: FontWeight.w700,
                      fontColor: black,
                    ),
                    textWidget(
                      text: productData.description,
                      overflow: TextOverflow.ellipsis,
                      fontSize: height * 0.014,
                      fontweight: FontWeight.w400,
                      fontColor: grey,
                    ),
                    SizedBox(height: height * 0.012),
                    textWidget(
                      text: "₹ ${productData.price}",
                      fontSize: height * 0.017,
                      fontweight: FontWeight.w900,
                      fontColor: black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

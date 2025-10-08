import 'package:e_commerece/Services/dbservice.dart';
import 'package:e_commerece/common_widgets/buttonwidget.dart';
import 'package:e_commerece/common_widgets/common_colors.dart';
import 'package:e_commerece/common_widgets/textWidget.dart';
import 'package:e_commerece/Controllers/cartContoller.dart';
import 'package:e_commerece/Models/product_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  final bool isInMyCart;
  const ProductDetails({
    required this.product,
    required this.isInMyCart,
    super.key,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late double height, width;
  DBService dbService = DBService();

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Hero(
      tag: widget.product.docId,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: textWidget(
            text: "Product Details ",
            fontSize: height * 0.02,
            fontweight: FontWeight.w700,
            fontColor: black,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: height * 0.4,
                    height: width * 0.8,
                    child: Image.asset(
                      'assets/${widget.product.image}.png',

                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                textWidget(
                  text: widget.product.name,
                  fontSize: height * 0.027,
                  fontweight: FontWeight.w900,
                  fontColor: black,
                ),
                SizedBox(height: height * 0.01),
                textWidget(
                  text: widget.product.price.toString(),
                  fontSize: height * 0.019,
                  fontweight: FontWeight.w700,
                  fontColor: black,
                ),

                SizedBox(height: height * 0.012),
                ReadMoreText(
                  widget.product.description,
                  trimLines: 2,
                  colorClickableText: grey,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...Read more',
                  trimExpandedText: ' Read Less',
                  style: GoogleFonts.poppins(
                    fontSize: height * 0.017,
                    fontWeight: FontWeight.w400,
                    color: black,
                  ),
                ),
                SizedBox(height: height * 0.04),
                Obx(() {
                  if (cartController.loading.value) {
                    return SizedBox();
                  }
                  bool isInMyCart = cartController.myCart.contains(
                    widget.product.docId,
                  );

                  return Align(
                    alignment: Alignment.topCenter,
                    child: !isInMyCart
                        ? InkWell(
                            onTap: () async {
                              EasyLoading.show(status: "Adding to cart");

                              await cartController.addToCart(widget.product);
                              EasyLoading.dismiss();
                            },
                            child: buttonWidget(
                              text: "Add to cart",
                              fontSize: height * 0.017,
                              fontweight: FontWeight.w500,
                              fontColor: white,
                              buttonWidth: width * 0.8,
                              verticalPadding: 20,
                              buttonColor: black,
                            ),
                          )
                        : buttonWidget(
                            text: "Added to Cart",
                            fontSize: height * 0.017,
                            fontweight: FontWeight.w500,
                            fontColor: black,
                            buttonWidth: width * 0.8,
                            verticalPadding: 20,
                            buttonColor: white,
                            borderColor: black,
                          ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

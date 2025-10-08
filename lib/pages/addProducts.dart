import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece/common_widgets/buttonwidget.dart';
import 'package:e_commerece/common_widgets/common_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController productName = TextEditingController();
  TextEditingController productDes = TextEditingController();
  TextEditingController productPrice = TextEditingController();

  List category = [
    "Electronics",
    "Clothing & Apparel",
    "Home & Kitchen",
    "Beauty Products",
  ];

  List<Map<String, dynamic>> products = [
    {
      "name": "iPhone 16e",
      "description":
          "A sleek, budget-friendly smartphone offering seamless iOS experience and reliable performance with long battery life and advanced camera features.",
      "price": 35296,
      "image": "e1",
      "category": "Electronics",
    },
    {
      "name": "Samsung Galaxy S25 5G",
      "description":
          "Features a stunning display, powerful camera system, and 5G connectivity for a premium mobile experience.",
      "price": 74999,
      "image": "e2",
      "category": "Electronics",
    },
    {
      "name": "OnePlus Nord CE5",
      "description":
          "Delivers fast performance, smooth display, and 5G support at an accessible price point.",
      "price": 22999,
      "image": "e3",
      "category": "Electronics",
    },
    {
      "name": "HP Spectre X360 Laptop",
      "description":
          "A versatile 2-in-1 laptop with a 360° hinge, offering both tablet and laptop functionalities with premium build quality.",
      "price": 159480,
      "image": "e4",
      "category": "Electronics",
    },
    {
      "name": "Dell XPS 13 Laptop",
      "description":
          "Known for its compact design and powerful performance, ideal for professionals on the go.",
      "price": 207989,
      "image": "e5",
      "category": "Electronics",
    },

    // Clothing & Apparel
    {
      "name": "Levi's 501 Jeans",
      "description":
          "Classic denim jeans offering a timeless fit and durable quality, perfect for casual and semi-formal wear.",
      "price": 3499,
      "image": "c1",
      "category": "Clothing & Apparel",
    },
    {
      "name": "Nike Air Max 270",
      "description":
          "Stylish sneakers with visible Air cushioning for comfort and support during sports and casual wear.",
      "price": 12995,
      "image": "c2",
      "category": "Clothing & Apparel",
    },
    {
      "name": "Adidas Trefoil Hoodie",
      "description":
          "A cozy hoodie featuring the iconic Trefoil logo, perfect for casual wear and staying warm during winter.",
      "price": 4299,
      "image": "c3",
      "category": "Clothing & Apparel",
    },
    {
      "name": "Puma Suede Classic",
      "description":
          "Retro-inspired sneakers known for their comfort and sleek design, ideal for everyday use.",
      "price": 6999,
      "image": "c4",
      "category": "Clothing & Apparel",
    },
    {
      "name": "Zara Cotton Shirt",
      "description":
          "A versatile cotton shirt suitable for both formal and casual occasions, soft and breathable material.",
      "price": 1799,
      "image": "c5",
      "category": "Clothing & Apparel",
    },

    // Home & Kitchen
    {
      "name": "Philips Sonicare Toothbrush",
      "description":
          "Advanced toothbrush offering superior plaque control and gum health with smart sensor technology.",
      "price": 63249,
      "image": "h1",
      "category": "Home & Kitchen",
    },
    {
      "name": "Dyson V15 Vacuum",
      "description":
          "Cord-free vacuum cleaner with laser illumination to reveal hidden dust, ensuring a thorough clean.",
      "price": 65900,
      "image": "h2",
      "category": "Home & Kitchen",
    },
    {
      "name": "Ninja Foodi 9-in-1 Cooker",
      "description":
          "Combines nine cooking functions in one appliance, perfect for quick and versatile meal preparation.",
      "price": 64215,
      "image": "h3",
      "category": "Home & Kitchen",
    },
    {
      "name": "Instant Pot Duo 6-Quart",
      "description":
          "Multi-functional cooker that simplifies meal preparation with one-touch cooking programs.",
      "price": 8499,
      "image": "h4",
      "category": "Home & Kitchen",
    },
    {
      "name": "Nutcracker Kitchen Tool",
      "description":
          "Durable tool designed to easily crack open nuts, enhancing your kitchen's efficiency and convenience.",
      "price": 9778,
      "image": "h5",
      "category": "Home & Kitchen",
    },

    // Beauty Products
    {
      "name": "L'Oreal Revitalift Cream",
      "description":
          "Anti-aging cream that hydrates and firms skin, reducing wrinkles and providing a youthful glow.",
      "price": 1299,
      "image": "b1",
      "category": "Beauty Products",
    },
    {
      "name": "Maybelline Fit Me Foundation",
      "description":
          "Lightweight foundation that provides natural coverage and smooth finish for all skin types.",
      "price": 699,
      "image": "b2",
      "category": "Beauty Products",
    },
    {
      "name": "Neutrogena Hydro Boost Gel",
      "description":
          "Hydrating gel moisturizer that absorbs quickly, leaving skin refreshed and soft without greasiness.",
      "price": 899,
      "image": "b3",
      "category": "Beauty Products",
    },
    {
      "name": "Dove Hair Therapy Shampoo",
      "description":
          "Nourishing shampoo that repairs and strengthens hair, providing smoothness and shine.",
      "price": 499,
      "image": "b4",
      "category": "Beauty Products",
    },
    {
      "name": "Lakme Eye Shadow Palette",
      "description":
          "Vibrant eyeshadow palette with long-lasting colors and smooth application for all occasions.",
      "price": 799,
      "image": "b5",
      "category": "Beauty Products",
    },
  ];

  late double height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                for (var i in products) {
                  Map d = i;
                  FirebaseFirestore.instance.collection("products").add({
                    "name": d['name'],
                    "des": d['description'],
                    'price': d['price'],
                    'image': d['image'],
                    'category': d['category'],
                  });
                }
              },
              child: buttonWidget(
                text: "Add to cart",
                fontSize: height * 0.017,
                fontweight: FontWeight.w500,
                fontColor: secondaryColor,
                buttonWidth: width * 0.8,
                verticalPadding: 20,
                buttonColor: black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

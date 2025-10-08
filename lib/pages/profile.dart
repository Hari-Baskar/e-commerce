import 'package:e_commerece/Account/checkauth.dart';
import 'package:e_commerece/Controllers/cartContoller.dart';
import 'package:e_commerece/Controllers/productsContoller.dart';
import 'package:e_commerece/Controllers/usercontroller.dart';
import 'package:e_commerece/Services/authService.dart';
import 'package:e_commerece/pages/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:e_commerece/common_widgets/common_colors.dart';
import 'package:e_commerece/common_widgets/textWidget.dart';
import 'package:e_commerece/common_widgets/buttonwidget.dart';
import 'package:get_storage/get_storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = GetStorage();

  AuthService authService = AuthService();
  late double height, width;
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: textWidget(
          text: "My Profile",
          fontSize: height * 0.022,
          fontweight: FontWeight.w700,
          fontColor: black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.02, width: width),

              CircleAvatar(
                radius: width * 0.21,
                backgroundColor: green,

                child: CircleAvatar(
                  radius: width * 0.2,
                  backgroundImage: AssetImage('assets/profile.jpeg'),
                ),
              ),

              SizedBox(height: height * 0.03),

              Obx(
                () => textWidget(
                  text: userController.name.toString(),
                  fontSize: height * 0.027,
                  fontweight: FontWeight.w700,
                  fontColor: black,
                ),
              ),
              SizedBox(height: height * 0.02),

              Obx(
                () => showDetailsCard(
                  title: "Phone",
                  data: '+91 ${userController.phone.toString()}',
                ),
              ),

              SizedBox(height: height * 0.01),

              Obx(
                () => showDetailsCard(
                  title: "Email",
                  data: userController.email.toString(),
                ),
              ),
              SizedBox(height: height * 0.01),

              Obx(
                () => showDetailsCard(
                  title: "Address",
                  data: userController.address.toString(),
                ),
              ),

              SizedBox(height: height * 0.05),

              InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                child: buttonWidget(
                  text: "Edit Profile",
                  fontSize: height * 0.018,
                  fontweight: FontWeight.w600,
                  fontColor: white,
                  buttonWidth: width * 0.8,
                  verticalPadding: 15,
                  buttonColor: black,
                ),
              ),

              SizedBox(height: height * 0.02),

              InkWell(
                onTap: () async {
                  EasyLoading.show(status: "Logging Out");
                  await authService.logout();
                  Get.delete<UserController>();
                  Get.delete<CartController>();
                  Get.delete<ProductController>();
                  EasyLoading.dismiss();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => CheckAuth()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: buttonWidget(
                  text: "Logout",
                  fontSize: height * 0.018,
                  fontweight: FontWeight.w600,
                  fontColor: black,
                  buttonWidth: width * 0.8,
                  verticalPadding: 15,
                  buttonColor: white,
                  borderColor: black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDetailsCard({required String title, required String data}) {
    return Container(
      width: width * 0.85,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          textWidget(
            text: title,
            fontSize: height * 0.015,
            fontweight: FontWeight.w500,
            fontColor: grey,
          ),
          SizedBox(height: height * 0.01),
          textWidget(
            text: data,
            fontSize: height * 0.018,
            fontweight: FontWeight.w600,
            fontColor: black,
          ),
        ],
      ),
    );
  }
}

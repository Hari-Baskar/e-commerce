import 'package:e_commerece/Controllers/usercontroller.dart';
import 'package:e_commerece/common_widgets/buttonwidget.dart';
import 'package:e_commerece/common_widgets/common_colors.dart';
import 'package:e_commerece/common_widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserController userController = Get.find<UserController>();

  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController address;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user values
    name = TextEditingController(text: userController.name.value);
    phone = TextEditingController(text: userController.phone.value);
    address = TextEditingController(text: userController.address.value);
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                textfieldWidget(
                  hintColor: grey,
                  hintSize: height * 0.017,
                  controller: name,
                  hintText: "Enter your name",
                  validate: (val) =>
                      val == null || val.isEmpty ? "Enter name" : null,
                ),
                SizedBox(height: height * 0.03),
                textfieldWidget(
                  controller: phone,
                  hintText: "Enter your phone",
                  type: TextInputType.number,
                  validate: (val) {
                    if (val == null || val.isEmpty) return "Enter phone";
                    if (val.length != 10) return "Phone should be 10 digits";
                    return null;
                  },
                  hintColor: grey,
                  hintSize: height * 0.017,
                ),
                SizedBox(height: height * 0.03),
                textfieldWidget(
                  hintColor: grey,
                  hintSize: height * 0.017,
                  controller: address,
                  hintText: "Enter your address",
                  minlines: 2,
                  validate: (val) =>
                      val == null || val.isEmpty ? "Enter address" : null,
                ),
                SizedBox(height: height * 0.05),
                InkWell(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      EasyLoading.show(status: "Updating Profile");
                      await userController.updateUser(
                        n: name.text,
                        p: phone.text,
                        a: address.text,
                      );
                      EasyLoading.showSuccess("Profile Updated Succesfully");

                      Navigator.pop(context);
                    }
                  },
                  child: buttonWidget(
                    text: "Save Changes",
                    fontSize: height * 0.018,
                    fontweight: FontWeight.w600,
                    fontColor: white,
                    buttonWidth: width * 0.8,
                    verticalPadding: 15,
                    buttonColor: black,
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

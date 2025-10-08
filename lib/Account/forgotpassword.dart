import 'package:e_commerece/Services/authService.dart';
import 'package:e_commerece/common_widgets/buttonwidget.dart';
import 'package:e_commerece/common_widgets/common_colors.dart';
import 'package:e_commerece/common_widgets/snackbar.dart';
import 'package:e_commerece/common_widgets/textWidget.dart';
import 'package:e_commerece/common_widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  late double height, width;
  AuthService authService = AuthService();
  late AnimationController animateController;
  late Animation<double> animationOffset;
  @override
  void initState() {
    super.initState();
    animateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animationOffset = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animateController, curve: Curves.easeOut),
    );
    animateController.forward();
  }

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: textWidget(
          text: "Reset Password",
          fontSize: height * 0.02,
          fontweight: FontWeight.w500,
          fontColor: black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(width: width),
              AnimatedBuilder(
                animation: animationOffset,
                builder: (context, child) {
                  return Opacity(opacity: animationOffset.value, child: child);
                },
                child: SizedBox(
                  width: width * 0.8,

                  child: textfieldWidget(
                    prefixIcon: Icon(Icons.mail),
                    hintText: "Enter your email",
                    controller: email,
                    hintColor: grey,
                    hintSize: height * 0.017,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              InkWell(
                onTap: () async {
                  if (email.text.trim().isNotEmpty) {
                    EasyLoading.show(status: "Verifying email");
                    bool ispresent = await authService.forgotpassword(
                      email: email.text.trim(),
                    );
                    if (ispresent) {
                      EasyLoading.dismiss();
                      message(
                        context: context,
                        text: "Reset password email sent",
                        fontSize: height * 0.017,
                        fontweight: FontWeight.w500,
                        fontColor: secondaryColor,
                        messageColor: green,
                      );
                    } else {
                      EasyLoading.showError("Wrong email");
                    }
                  } else {
                    message(
                      context: context,
                      text: "Please fill the fields",
                      fontSize: height * 0.017,
                      fontweight: FontWeight.w500,
                      fontColor: secondaryColor,
                      messageColor: red,
                    );
                  }
                },
                child: buttonWidget(
                  text: "Login",
                  fontSize: height * 0.017,
                  fontweight: FontWeight.w500,
                  fontColor: secondaryColor,
                  buttonWidth: width * 0.8,
                  buttonColor: black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

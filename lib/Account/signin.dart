import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece/Account/forgotpassword.dart';
import 'package:e_commerece/Account/signup.dart';
import 'package:e_commerece/Services/authService.dart';
import 'package:e_commerece/Services/dbservice.dart';
import 'package:e_commerece/common_widgets/buttonwidget.dart';
import 'package:e_commerece/common_widgets/common_colors.dart';
import 'package:e_commerece/common_widgets/snackbar.dart';
import 'package:e_commerece/common_widgets/textWidget.dart';
import 'package:e_commerece/common_widgets/textfield.dart';
import 'package:e_commerece/pages/bottomBarPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final user = GetStorage();
  DBService dbService = DBService();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late double height, width;
  AuthService authService = AuthService();
  bool isobscure = true;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: textWidget(
          text: "Login",
          fontSize: height * 0.02,
          fontweight: FontWeight.w500,
          fontColor: black,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: width),

              SizedBox(
                width: width * 0.8,

                child: textfieldWidget(
                  prefixIcon: Icon(Icons.mail),
                  hintText: "Enter your email",
                  controller: email,
                  hintColor: grey,
                  hintSize: height * 0.017,
                ),
              ),

              SizedBox(height: height * 0.02),
              StatefulBuilder(
                builder: (context, localSetState) {
                  return SizedBox(
                    width: width * 0.8,

                    child: textfieldWidget(
                      prefixIcon: Icon(Icons.key),
                      hintText: "Enter your password",
                      suffix: IconButton(
                        onPressed: () {
                          localSetState(() {
                            isobscure = !isobscure;
                          });
                        },

                        icon: Icon(
                          isobscure ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      obscure: isobscure,
                      controller: password,
                      hintColor: grey,
                      hintSize: height * 0.017,
                    ),
                  );
                },
              ),

              SizedBox(height: height * 0.02),

              SizedBox(
                width: width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        );
                      },
                      child: textWidget(
                        text: "Forgot Password ?",
                        fontSize: height * 0.017,
                        fontweight: FontWeight.w500,
                        fontColor: black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              InkWell(
                onTap: () async {
                  if (email.text.trim().isNotEmpty &&
                      password.text.trim().isNotEmpty) {
                    EasyLoading.show(status: "Logging In");
                    String? uid = await authService.login(
                      email: email.text,
                      password: password.text,
                    );
                    if (uid != null) {
                      user.write("uid", uid);
                      DocumentSnapshot document = await dbService
                          .getUserDetails(uid: uid);
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      user.write("email", data['email']);
                      user.write("name", data['name']);
                      user.write('address', data['address']);
                      user.write("phone", data['phone']);

                      EasyLoading.dismiss();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomBarPage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      EasyLoading.showError("Wrong email or password");
                    }
                  } else {
                    message(
                      context: context,
                      text: "Please fill all the fields",
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
                  verticalPadding: 20,
                  fontweight: FontWeight.w500,
                  fontColor: secondaryColor,
                  buttonWidth: width * 0.8,
                  buttonColor: black,
                ),
              ),

              SizedBox(height: height * 0.04),
              SizedBox(
                width: width * 0.8,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account ? ",
                          style: GoogleFonts.poppins(
                            fontSize: height * 0.019,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },

                          text: "SignUp",
                          style: GoogleFonts.poppins(
                            fontSize: height * 0.019,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}

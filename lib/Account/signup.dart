import 'package:e_commerece/Account/signin.dart';
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
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  DBService dbService = DBService();
  AuthService authService = AuthService();
  final key = GlobalKey<FormState>();
  final user = GetStorage();
  String? gender;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    address.dispose();
    email.dispose();
    password.dispose();
    phone.dispose();
    super.dispose();
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  late double height, width;
  bool isobscure = true;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: textWidget(
          text: "SignUp",
          fontSize: height * 0.02,
          fontweight: FontWeight.w500,
          fontColor: black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: width),
                SizedBox(
                  width: width * 0.8,

                  child: textfieldWidget(
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return "enter your name";
                      }
                      return null;
                    },
                    prefixIcon: Icon(Icons.person),
                    hintText: "Enter your name",
                    controller: name,
                    hintColor: grey,
                    hintSize: height * 0.017,
                  ),
                ),

                SizedBox(height: height * 0.02),
                SizedBox(
                  width: width * 0.8,

                  child: textfieldWidget(
                    type: TextInputType.numberWithOptions(),
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return "enter your phone no";
                      } else if (val.length != 10) {
                        return "check your number";
                      }
                      return null;
                    },
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Phone No",
                    controller: phone,
                    hintColor: grey,
                    hintSize: height * 0.017,
                  ),
                ),

                SizedBox(height: height * 0.02),
                SizedBox(
                  width: width * 0.8,

                  child: textfieldWidget(
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return "enter your Address";
                      }
                      return null;
                    },
                    minlines: 2,
                    hintText: "Address",
                    controller: address,
                    hintColor: grey,
                    hintSize: height * 0.017,
                  ),
                ),

                SizedBox(height: height * 0.02),
                SizedBox(
                  width: width * 0.8,

                  child: textfieldWidget(
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return "enter your email";
                      }
                      return null;
                    },
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
                        validate: (val) {
                          if (val == null || val.isEmpty) {
                            return "enter your password";
                          }
                          return null;
                        },
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
                InkWell(
                  onTap: () async {
                    if (key.currentState!.validate()) {
                      EasyLoading.show(status: "Creating Account");
                      String? uid = await authService.createAccount(
                        email: email.text,
                        password: password.text,
                      );
                      if (uid != null) {
                        await dbService.setUser(
                          name: name.text,
                          address: address.text,
                          email: email.text,
                          phone: phone.text,
                          uid: uid,
                        );
                        user.write("uid", uid);
                        user.write("email", email.text);
                        user.write("name", name.text);
                        user.write('phone', phone.text);
                        user.write('address', address.text);
                        EasyLoading.dismiss();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomBarPage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    } else {
                      message(
                        context: context,
                        text: "Please fill all the fields",
                        fontSize: height * 0.017,
                        fontweight: FontWeight.w500,
                        fontColor: white,
                        messageColor: red,
                      );
                    }
                  },
                  child: buttonWidget(
                    text: "Create Account",
                    fontSize: height * 0.017,
                    fontweight: FontWeight.w500,
                    fontColor: white,
                    buttonWidth: width * 0.8,
                    verticalPadding: 20,
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
                            text: "Already have an account ? ",
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
                                    builder: (context) => SignIn(),
                                  ),
                                );
                              },

                            text: "Login",
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
      ),
    );
  }
}

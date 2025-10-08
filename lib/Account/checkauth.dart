import 'package:e_commerece/Account/signin.dart';
import 'package:e_commerece/pages/bottomBarPage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  final user = GetStorage();
  @override
  Widget build(BuildContext context) {
    String? uid = user.read("uid");
    if (uid != null) {
      return BottomBarPage();
    }
    return SignIn();
  }
}

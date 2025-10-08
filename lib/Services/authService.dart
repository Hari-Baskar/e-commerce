import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece/Services/dbservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  final DBService dbService = DBService();
  final user = GetStorage();

  login({required String email, required String password}) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user!.uid;
    } catch (e) {
      return null;
    }
  }

  createAccount({required String email, required String password}) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        EasyLoading.showError("This email is already registered!");
      } else if (e.code == 'invalid-email') {
        EasyLoading.showError("Please enter a valid email address.");
      } else if (e.code == 'weak-password') {
        EasyLoading.showError("Password should be at least 6 characters.");
      } else {
        EasyLoading.showError("Something went wrong. Please try again.");
      }
      return null;
    } catch (e) {
      EasyLoading.showError("Error: $e");
      return null;
    }
  }

  Future<bool> forgotpassword({required String email}) async {
    try {
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (query.docs.isEmpty) {
        return false;
      }

      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  logout() async {
    user.erase();
    await auth.signOut();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece/Models/cartModel.dart';
import 'package:get_storage/get_storage.dart';

class DBService {
  final firestore = FirebaseFirestore.instance;
  final user = GetStorage();

  getUserDetails({required String uid}) {
    return firestore.collection("users").doc(uid).get();
  }

  editProfile({required Map userDetails}) async {
    await firestore.collection('users').doc(user.read('uid')).update({
      "name": userDetails['name'],
      'address': userDetails['address'],
      'phone': userDetails['phone'],
    });
    user.remove('elatlng');
  }

  setUser({
    required String name,
    required String address,
    required String email,
    required String uid,
    required String phone,
  }) async {
    await firestore.collection("users").doc(uid).set({
      'name': name,
      'email': email,
      'address': address,
      'uid': uid,
      'phone': phone,
    });
  }

  getAllItems() {
    return firestore.collection("products").get();
  }

  addtoUserCart({required CartItem productData}) async {
    await firestore
        .collection("users")
        .doc(user.read("uid"))
        .collection('cart')
        .doc(productData.docId)
        .set({
          'name': productData.name,
          'des': productData.description,
          'price': productData.price,
          'image': productData.image,
          'category': productData.category,
          'quantity': 1,
        });
  }

  getCartDetails() {
    return firestore
        .collection("users")
        .doc(user.read("uid"))
        .collection('cart')
        .get();
  }

  removeCartItem(itemId) async {
    await firestore
        .collection("users")
        .doc(user.read("uid"))
        .collection('cart')
        .doc(itemId)
        .delete();
  }

  updateCartQuantity({required String itemId, required int quantity}) async {
    await firestore
        .collection("users")
        .doc(user.read("uid"))
        .collection('cart')
        .doc(itemId)
        .update({'qunatity': quantity});
  }
}

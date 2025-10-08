import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece/Services/dbservice.dart';
import 'package:e_commerece/Models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  RxList<String> categories = <String>[].obs;
  var isLoading = true.obs;
  DBService dbService = DBService();
  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() async {
    isLoading.value = true;
    List<Map<String, dynamic>> data = [];
    QuerySnapshot querySnapshot = await dbService.getAllItems();
    List<DocumentSnapshot> documents = querySnapshot.docs;

    for (var i in documents) {
      Map<String, dynamic> itemData = i.data() as Map<String, dynamic>;
      itemData.addAll({"docId": i.id});
      data.add(itemData);
    }

    for (var item in data) {
      products.add(Product.fromMap(item));
    }

    for (var p in products) {
      if (!categories.contains(p.category)) {
        categories.add(p.category);
      }
    }
    isLoading.value = false;
  }

  List<Product> getProductsByCategory(String category) {
    List<Product> filteredList = [];

    for (var product in products) {
      if (product.category == category) {
        filteredList.add(product);
      }
    }

    return filteredList;
  }
}

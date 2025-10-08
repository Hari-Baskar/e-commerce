import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece/Models/cartModel.dart';
import 'package:get/get.dart';
import '../Services/dbservice.dart';
import '../Models/product_model.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  RxList<dynamic> myCart = [].obs;
  var loading = true.obs;

  DBService dbService = DBService();

  @override
  void onInit() {
    super.onInit();
    getCartFromFirestore();
  }

  void getCartFromFirestore() async {
    loading.value = true;
    QuerySnapshot productsFromDb = await dbService.getCartDetails();
    List<DocumentSnapshot> documents = productsFromDb.docs;

    List<CartItem> loadedCart = [];
    for (var i in documents) {
      Map<String, dynamic> product = i.data() as Map<String, dynamic>;
      String docId = i.id;
      product['docId'] = docId;
      loadedCart.add(CartItem.fromMap(product));
      myCart.add(docId);
    }

    cartItems.value = loadedCart;
    loading.value = false;
  }

  Future<void> addToCart(Product product) async {
    CartItem newItem = CartItem(
      docId: product.docId,
      name: product.name,
      description: product.description,
      price: product.price,
      image: product.image,
      quantity: 1,
      category: product.category,
    );
    await dbService.addtoUserCart(productData: newItem);
    cartItems.add(newItem);
    myCart.add(product.docId);
    cartItems.refresh();
  }

  void removeFromCart(CartItem item) async {
    cartItems.removeWhere((c) => c.docId == item.docId);
    cartItems.refresh();
    myCart.remove(item.docId);
    cartItems.remove(item);
    await dbService.removeCartItem(item.docId);
  }

  void incrementQuantity(CartItem item) async {
    item.quantity++;
    cartItems.refresh();
    await dbService.updateCartQuantity(
      itemId: item.docId,
      quantity: item.quantity,
    );
  }

  void decrementQuantity(CartItem item) async {
    if (item.quantity > 1) {
      item.quantity--;
      cartItems.refresh();
      await dbService.updateCartQuantity(
        itemId: item.docId,
        quantity: item.quantity,
      );
    }
  }

  double getSubtotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Services/dbservice.dart';

class UserController extends GetxController {
  var name = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;
  var email = ''.obs;

  final DBService dbService = DBService();
  final user = GetStorage();

  @override
  void onInit() {
    super.onInit();

    name.value = user.read("name") ?? '';
    phone.value = user.read("phone") ?? '';
    address.value = user.read("address") ?? '';
    email.value = user.read("email") ?? '';
  }

  Future<void> updateUser({
    required String n,
    required String p,
    required String a,
  }) async {
    name.value = n;
    phone.value = p;
    address.value = a;

    user.write("name", n);
    user.write("phone", p);
    user.write("address", a);

    await dbService.editProfile(
      userDetails: {'name': n, 'phone': p, 'address': a},
    );
  }
}

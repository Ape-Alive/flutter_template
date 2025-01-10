import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoggedIn = false.obs;
  void login(String username, String password) {
    // 模拟登录逻辑
    isLoggedIn.value = true;
    // Get.snackbar("Login", "Welcome, $username!");
  }

  void logout() {
    isLoggedIn.value = false;
    Get.snackbar("Logout", "You have been logged out.");
  }
}

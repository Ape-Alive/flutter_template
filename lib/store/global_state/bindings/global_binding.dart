import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import 'package:flutter_template/modules/auth/controllers/login_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(ThemeController());
  }
}

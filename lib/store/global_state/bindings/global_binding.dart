import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
  }
}

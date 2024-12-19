import 'package:get/get.dart';

class HomeController extends GetxController {
  var curPage = ''.obs;
  void setCurPage(String newCurPage) {
    curPage.value = newCurPage;
  }
}

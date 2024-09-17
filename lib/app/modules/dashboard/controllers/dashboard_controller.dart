

import 'package:get/get.dart';

class DashboardController extends GetxController {

  final selectedIndex = 0.obs;

  void onItemTapped(int index) {

    selectedIndex.value = index;

  }

  @override
  void onInit() {

    super.onInit();


  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}

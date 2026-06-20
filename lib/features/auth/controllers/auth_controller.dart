import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  void login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.offAllNamed('/main-nav');
  }

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed('/login');
  }
}

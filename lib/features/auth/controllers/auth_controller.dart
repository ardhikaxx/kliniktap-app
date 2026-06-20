import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  void login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.offAllNamed(Routes.mainNav);
  }

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(Routes.login);
  }
}

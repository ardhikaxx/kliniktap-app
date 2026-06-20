import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../../data/repositories/dashboard_repository.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardRepository());
    Get.lazyPut(() => DashboardController(repository: Get.find()));
  }
}

import 'package:get/get.dart';
import '../controllers/bed_management_controller.dart';

class BedManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BedManagementController());
  }
}

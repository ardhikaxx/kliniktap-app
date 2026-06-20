import 'package:get/get.dart';
import '../controllers/prescription_controller.dart';
import '../../../data/repositories/prescription_repository.dart';

class PrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrescriptionRepository());
    Get.lazyPut(() => PrescriptionController(repository: Get.find()));
  }
}

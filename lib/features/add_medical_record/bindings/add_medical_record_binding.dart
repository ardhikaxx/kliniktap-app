import 'package:get/get.dart';
import '../controllers/add_medical_record_controller.dart';

class AddMedicalRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMedicalRecordController());
  }
}

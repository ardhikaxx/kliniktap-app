import 'package:get/get.dart';
import '../controllers/medication_adherence_controller.dart';

class MedicationAdherenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicationAdherenceController());
  }
}

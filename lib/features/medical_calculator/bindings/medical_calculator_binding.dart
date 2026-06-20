import 'package:get/get.dart';
import '../controllers/medical_calculator_controller.dart';

class MedicalCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicalCalculatorController());
  }
}

import 'package:get/get.dart';
import '../controllers/pain_scale_controller.dart';

class PainScaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PainScaleController());
  }
}

import 'package:get/get.dart';
import '../controllers/schedule_profile_controller.dart';

class ScheduleProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScheduleProfileController(repository: Get.find()));
  }
}

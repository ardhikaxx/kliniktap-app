import 'package:get/get.dart';
import '../controllers/main_nav_controller.dart';
import '../../dashboard/bindings/dashboard_binding.dart';
import '../../medical_record/bindings/medical_record_binding.dart';
import '../../schedule_profile/bindings/schedule_profile_binding.dart';

class MainNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainNavController());
    DashboardBinding().dependencies();
    MedicalRecordBinding().dependencies();
    ScheduleProfileBinding().dependencies();
  }
}

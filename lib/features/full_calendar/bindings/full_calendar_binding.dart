import 'package:get/get.dart';
import '../controllers/full_calendar_controller.dart';

class FullCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FullCalendarController());
  }
}

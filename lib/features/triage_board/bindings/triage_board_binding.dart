import 'package:get/get.dart';
import '../controllers/triage_board_controller.dart';

class TriageBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TriageBoardController());
  }
}

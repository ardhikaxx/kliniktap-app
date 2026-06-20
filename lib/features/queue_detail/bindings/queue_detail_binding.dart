import 'package:get/get.dart';
import '../controllers/queue_detail_controller.dart';

class QueueDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QueueDetailController());
  }
}

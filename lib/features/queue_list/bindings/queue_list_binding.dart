import 'package:get/get.dart';
import '../controllers/queue_list_controller.dart';
import '../../dashboard/repositories/dashboard_repository.dart';

class QueueListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardRepository());
    Get.lazyPut(() => QueueListController(repository: Get.find()));
  }
}

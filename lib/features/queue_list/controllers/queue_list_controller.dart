import 'package:get/get.dart';
import '../../dashboard/repositories/dashboard_repository.dart';
import '../../../data/models/patient_queue_model.dart';

class QueueListController extends GetxController {
  final DashboardRepository repository;

  QueueListController({required this.repository});

  final RxList<PatientQueueModel> queueList = <PatientQueueModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQueueList();
  }

  void fetchQueueList() async {
    isLoading.value = true;
    try {
      final list = await repository.getQueueList();
      queueList.assignAll(list);
    } finally {
      isLoading.value = false;
    }
  }
}

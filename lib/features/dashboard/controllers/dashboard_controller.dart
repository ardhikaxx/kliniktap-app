import 'package:get/get.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/models/patient_queue_model.dart';
import '../../../data/repositories/dashboard_repository.dart';

class DashboardController extends GetxController {
  final DashboardRepository repository;

  DashboardController({required this.repository});

  final RxBool isLoading = true.obs;
  final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
  final RxList<PatientQueueModel> queueList = <PatientQueueModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    isLoading.value = true;
    try {
      final doc = await repository.getDoctorProfile();
      final queue = await repository.getPatientQueue();
      doctor.value = doc;
      queueList.assignAll(queue);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data dasbor');
    } finally {
      isLoading.value = false;
    }
  }
}

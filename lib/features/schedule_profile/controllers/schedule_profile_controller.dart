import 'package:get/get.dart';
import '../../../data/models/doctor_model.dart';

import '../../../data/repositories/dashboard_repository.dart';

class ScheduleProfileController extends GetxController {
  final DashboardRepository repository;

  ScheduleProfileController({required this.repository});

  final isLoading = true.obs;
  final doctor = Rxn<DoctorModel>();

  final List<String> scheduleDays = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];
  final List<String> scheduleHours = ['08:00 - 12:00', '13:00 - 16:00', '16:00 - 20:00'];

  @override
  void onInit() {
    super.onInit();
    _fetchProfile();
  }

  void _fetchProfile() async {
    isLoading.value = true;
    try {
      final doc = await repository.getDoctorProfile();
      doctor.value = doc;
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat profil');
    }
    isLoading.value = false;
  }

  void logout() {
    Get.snackbar('Logout', 'Anda telah keluar dari sesi ini.');
  }
}

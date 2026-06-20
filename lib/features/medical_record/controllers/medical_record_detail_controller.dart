import 'package:get/get.dart';
import '../../../data/models/patient_queue_model.dart';

class MedicalHistoryItem {
  final String date;
  final String diagnosis;
  final String doctorName;
  final String notes;

  MedicalHistoryItem({
    required this.date,
    required this.diagnosis,
    required this.doctorName,
    required this.notes,
  });
}

class MedicalRecordDetailController extends GetxController {
  late PatientQueueModel patient;
  final isLoading = true.obs;

  // Mock patient details
  final patientAge = 28.obs;
  final patientGender = 'Laki-laki'.obs;
  final patientBloodType = 'O'.obs;
  final patientWeight = '70 kg'.obs;
  final patientHeight = '175 cm'.obs;
  final allergies = <String>['Debu', 'Seafood'].obs;

  final history = <MedicalHistoryItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    patient = Get.arguments as PatientQueueModel;
    _fetchDetails();
  }

  void _fetchDetails() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Simulate network call

    history.assignAll([
      MedicalHistoryItem(
        date: '12 Mei 2026',
        diagnosis: 'ISPA',
        doctorName: 'dr. Sarah Wijaya',
        notes: 'Pasien mengeluh batuk berdahak dan flu sejak 3 hari yang lalu. Diberikan antibiotik dan obat batuk.',
      ),
      MedicalHistoryItem(
        date: '03 Feb 2026',
        diagnosis: 'Gastritis Akut',
        doctorName: 'dr. Budi Santoso',
        notes: 'Nyeri ulu hati, mual, dan muntah. Disarankan hindari makanan pedas dan asam.',
      ),
      MedicalHistoryItem(
        date: '10 Nov 2025',
        diagnosis: 'Demam Berdarah',
        doctorName: 'dr. Sarah Wijaya',
        notes: 'Dirawat inap selama 4 hari. Trombosit terendah 80.000.',
      ),
    ]);

    isLoading.value = false;
  }
}

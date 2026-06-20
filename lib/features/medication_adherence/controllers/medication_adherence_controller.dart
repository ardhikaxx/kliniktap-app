import 'package:get/get.dart';

class MedicationPatient {
  final String name;
  final String disease;
  final int adherencePercentage;
  final String lastTaken;

  MedicationPatient({
    required this.name,
    required this.disease,
    required this.adherencePercentage,
    required this.lastTaken,
  });
}

class MedicationAdherenceController extends GetxController {
  final patients = <MedicationPatient>[].obs;

  @override
  void onInit() {
    super.onInit();
    patients.assignAll([
      MedicationPatient(name: 'Ahmad Santoso', disease: 'Hipertensi', adherencePercentage: 95, lastTaken: 'Hari ini, 07:00'),
      MedicationPatient(name: 'Siti Aminah', disease: 'Diabetes Mellitus Tipe 2', adherencePercentage: 80, lastTaken: 'Hari ini, 08:30'),
      MedicationPatient(name: 'Budi Darmawan', disease: 'Tuberkulosis (TB)', adherencePercentage: 45, lastTaken: 'Kemarin, 06:00'),
      MedicationPatient(name: 'Ani Yudhoyono', disease: 'Asma Bronkial', adherencePercentage: 100, lastTaken: 'Hari ini, 06:15'),
      MedicationPatient(name: 'Joko Anwar', disease: 'Penyakit Jantung Koroner', adherencePercentage: 60, lastTaken: '2 Hari Lalu'),
    ]);
  }
}

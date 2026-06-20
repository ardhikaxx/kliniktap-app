import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/medicine_model.dart';
import '../../../data/models/patient_queue_model.dart';
import '../../../data/repositories/prescription_repository.dart';

class PrescriptionController extends GetxController {
  final PrescriptionRepository repository;
  
  PrescriptionController({required this.repository});

  late PatientQueueModel patient;
  final TextEditingController diagnosisController = TextEditingController();

  final RxInt currentStep = 0.obs;
  
  final RxList<MedicineModel> medicines = <MedicineModel>[].obs;
  final RxList<MedicineModel> searchResults = <MedicineModel>[].obs;
  
  final Rx<MedicineModel?> selectedMedicine = Rx<MedicineModel?>(null);
  final RxString selectedFreq = "".obs;
  final RxString selectedTiming = "".obs;

  @override
  void onInit() {
    super.onInit();
    patient = Get.arguments as PatientQueueModel;
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    try {
      final list = await repository.getMedicines();
      medicines.assignAll(list);
      searchResults.assignAll(list);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat daftar obat');
    }
  }

  void searchMedicine(String query) {
    if (query.isEmpty) {
      searchResults.assignAll(medicines);
      return;
    }
    final lowerQuery = query.toLowerCase();
    searchResults.assignAll(medicines.where((med) => 
      med.name.toLowerCase().contains(lowerQuery)
    ));
  }

  void selectMedicine(MedicineModel med) {
    selectedMedicine.value = med;
    searchResults.clear();
  }

  void clearMedicine() {
    selectedMedicine.value = null;
    searchResults.assignAll(medicines);
  }

  void nextStep() {
    if (currentStep.value < 2) {
      if (currentStep.value == 1 && selectedMedicine.value == null) {
        Get.snackbar('Perhatian', 'Pilih obat terlebih dahulu');
        return;
      }
      currentStep.value++;
    }
  }

  void prevStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void submitPrescription() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    await Future.delayed(const Duration(seconds: 1));
    Get.back(); // close dialog
    Get.snackbar('Berhasil', 'Resep PDF akan dikirimkan via WhatsApp');
    Get.offAllNamed('/main_nav');
  }
}

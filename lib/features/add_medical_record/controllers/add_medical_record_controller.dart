import 'package:get/get.dart';
import '../../../data/models/patient_queue_model.dart';

class AddMedicalRecordController extends GetxController {
  late final PatientQueueModel patient;

  @override
  void onInit() {
    super.onInit();
    patient = Get.arguments as PatientQueueModel;
  }

  void saveAndCreatePrescription() {
    // In a real app, save the EMR to the database here
    Get.snackbar(
      'Berhasil', 
      'Rekam medis berhasil disimpan',
      snackPosition: SnackPosition.BOTTOM,
    );
    // Then proceed to prescription
    Get.offNamed('/prescription', arguments: patient);
  }
}

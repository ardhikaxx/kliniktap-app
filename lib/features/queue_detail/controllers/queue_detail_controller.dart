import 'package:get/get.dart';
import '../../../data/models/patient_queue_model.dart';
import '../../../app/routes/app_routes.dart';

class QueueDetailController extends GetxController {
  late final PatientQueueModel patient;

  @override
  void onInit() {
    super.onInit();
    patient = Get.arguments as PatientQueueModel;
  }

  void startExamination() {
    Get.toNamed(Routes.addMedicalRecord, arguments: patient);
  }
}

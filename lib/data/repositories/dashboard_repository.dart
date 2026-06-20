import '../models/doctor_model.dart';
import '../models/patient_queue_model.dart';
import '../../../core/services/mock_data_service.dart';

class DashboardRepository {
  final MockDataService _mockService = MockDataService();

  Future<DoctorModel> getDoctorProfile() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network
    final data = await _mockService.loadJson('assets/mock/doctor.json');
    return DoctorModel.fromJson(data);
  }

  Future<List<PatientQueueModel>> getPatientQueue() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network
    final data = await _mockService.loadJson('assets/mock/patient_queue.json');
    return (data as List).map((e) => PatientQueueModel.fromJson(e)).toList();
  }
}

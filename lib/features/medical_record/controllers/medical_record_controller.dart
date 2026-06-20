import 'package:get/get.dart';
import '../../../data/models/patient_queue_model.dart';

class MedicalRecordController extends GetxController {
  final isLoading = true.obs;
  final searchKeyword = ''.obs;
  
  final _allRecords = <PatientQueueModel>[].obs;
  
  List<PatientQueueModel> get filteredRecords {
    if (searchKeyword.value.isEmpty) {
      return _allRecords;
    }
    return _allRecords.where((patient) => 
      patient.patientName.toLowerCase().contains(searchKeyword.value.toLowerCase())
    ).toList();
  }

  @override
  void onInit() {
    super.onInit();
    _fetchRecords();
  }

  void _fetchRecords() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Simulate network call
    
    _allRecords.value = [
      PatientQueueModel(
        id: 'P001',
        patientName: 'Budi Santoso',
        avatarUrl: 'https://i.pravatar.cc/150?u=budi',
        appointmentTime: '09:00',
        priority: 'high',
      ),
      PatientQueueModel(
        id: 'P002',
        patientName: 'Siti Aminah',
        avatarUrl: 'https://i.pravatar.cc/150?u=siti',
        appointmentTime: '09:30',
        priority: 'medium',
      ),
      PatientQueueModel(
        id: 'P003',
        patientName: 'Rudi Hartono',
        avatarUrl: 'https://i.pravatar.cc/150?u=rudi',
        appointmentTime: '10:00',
        priority: 'low',
      ),
      PatientQueueModel(
        id: 'P004',
        patientName: 'Ayu Lestari',
        avatarUrl: 'https://i.pravatar.cc/150?u=ayu',
        appointmentTime: '10:30',
        priority: 'low',
      ),
    ];
    
    isLoading.value = false;
  }

  void search(String keyword) {
    searchKeyword.value = keyword;
  }
}

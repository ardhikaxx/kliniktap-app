import '../models/medicine_model.dart';
import '../../../core/services/mock_data_service.dart';

class PrescriptionRepository {
  final MockDataService _mockService = MockDataService();

  Future<List<MedicineModel>> getMedicines() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final data = await _mockService.loadJson('assets/mock/medicines.json');
    return (data as List).map((e) => MedicineModel.fromJson(e)).toList();
  }
}

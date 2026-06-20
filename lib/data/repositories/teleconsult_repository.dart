import '../models/chat_message_model.dart';
import '../../../core/services/mock_data_service.dart';

class TeleconsultRepository {
  final MockDataService _mockService = MockDataService();

  Future<List<ChatMessageModel>> getChatHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final data = await _mockService.loadJson('assets/mock/chat_messages.json');
    return (data as List).map((e) => ChatMessageModel.fromJson(e)).toList();
  }
}

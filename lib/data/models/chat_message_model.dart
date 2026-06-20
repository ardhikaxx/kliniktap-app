class ChatMessageModel {
  final String id;
  final String sender;
  final String message;
  final String time;

  ChatMessageModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.time,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      sender: json['sender'] ?? '',
      message: json['message'] ?? '',
      time: json['time'] ?? '',
    );
  }
}

class PatientQueueModel {
  final String id;
  final String patientName;
  final String avatarUrl;
  final String appointmentTime;
  final String priority;

  PatientQueueModel({
    required this.id,
    required this.patientName,
    required this.avatarUrl,
    required this.appointmentTime,
    required this.priority,
  });

  factory PatientQueueModel.fromJson(Map<String, dynamic> json) {
    return PatientQueueModel(
      id: json['id'] ?? '',
      patientName: json['patient_name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      appointmentTime: json['appointment_time'] ?? '',
      priority: json['priority'] ?? 'low',
    );
  }
}

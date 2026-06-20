class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String avatarUrl;
  final bool isOnline;
  final DoctorStats stats;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.avatarUrl,
    required this.isOnline,
    required this.stats,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      isOnline: json['is_online'] ?? false,
      stats: DoctorStats.fromJson(json['stats'] ?? {}),
    );
  }
}

class DoctorStats {
  final int queueToday;
  final int prescriptionsIssued;
  final int tasksCompleted;

  DoctorStats({
    required this.queueToday,
    required this.prescriptionsIssued,
    required this.tasksCompleted,
  });

  factory DoctorStats.fromJson(Map<String, dynamic> json) {
    return DoctorStats(
      queueToday: json['queue_today'] ?? 0,
      prescriptionsIssued: json['prescriptions_issued'] ?? 0,
      tasksCompleted: json['tasks_completed'] ?? 0,
    );
  }
}

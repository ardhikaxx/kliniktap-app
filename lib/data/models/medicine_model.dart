class MedicineModel {
  final String id;
  final String name;
  final String category;
  final String commonDosage;

  MedicineModel({
    required this.id,
    required this.name,
    required this.category,
    required this.commonDosage,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      commonDosage: json['common_dosage'] ?? '',
    );
  }
}

import 'package:get/get.dart';

enum TriageLevel { red, yellow, green }

class TriagePatient {
  final String id;
  final String name;
  final String complaint;
  TriageLevel level;

  TriagePatient({
    required this.id,
    required this.name,
    required this.complaint,
    required this.level,
  });
}

class TriageBoardController extends GetxController {
  final patients = <TriagePatient>[].obs;

  @override
  void onInit() {
    super.onInit();
    patients.addAll([
      TriagePatient(id: 'P01', name: 'Ahmad Santoso', complaint: 'Nyeri dada hebat, sesak napas', level: TriageLevel.red),
      TriagePatient(id: 'P02', name: 'Siti Aminah', complaint: 'Pendarahan hebat di kaki', level: TriageLevel.red),
      TriagePatient(id: 'P03', name: 'Budi Darmawan', complaint: 'Patah tulang lengan (Fraktur tertutup)', level: TriageLevel.yellow),
      TriagePatient(id: 'P04', name: 'Ani Yudhoyono', complaint: 'Demam tinggi 39.5C, mual', level: TriageLevel.yellow),
      TriagePatient(id: 'P05', name: 'Dewi Lestari', complaint: 'Luka lecet ringan, flu', level: TriageLevel.green),
      TriagePatient(id: 'P06', name: 'Joko Anwar', complaint: 'Keseleo pergelangan kaki', level: TriageLevel.green),
      TriagePatient(id: 'P07', name: 'Rina Nose', complaint: 'Batuk berdahak 3 hari', level: TriageLevel.green),
    ]);
  }

  List<TriagePatient> get redPatients => patients.where((p) => p.level == TriageLevel.red).toList();
  List<TriagePatient> get yellowPatients => patients.where((p) => p.level == TriageLevel.yellow).toList();
  List<TriagePatient> get greenPatients => patients.where((p) => p.level == TriageLevel.green).toList();

  void updatePatientLevel(String id, TriageLevel newLevel) {
    final index = patients.indexWhere((p) => p.id == id);
    if (index != -1) {
      final p = patients[index];
      p.level = newLevel;
      patients[index] = p; // trigger update
    }
  }
}

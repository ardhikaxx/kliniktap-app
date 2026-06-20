import 'package:get/get.dart';

enum BedStatus { available, occupied, cleaning, maintenance }

class BedItem {
  final String id;
  final String name;
  final String room;
  final BedStatus status;
  final String? patientName;
  final int? admittedDays;

  BedItem({
    required this.id,
    required this.name,
    required this.room,
    required this.status,
    this.patientName,
    this.admittedDays,
  });
}

class BedManagementController extends GetxController {
  final beds = <BedItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockBeds();
  }

  void _loadMockBeds() {
    beds.assignAll([
      BedItem(id: 'B01', name: 'Bed 01', room: 'Melati (VIP)', status: BedStatus.occupied, patientName: 'Ahmad Santoso', admittedDays: 3),
      BedItem(id: 'B02', name: 'Bed 02', room: 'Melati (VIP)', status: BedStatus.available),
      BedItem(id: 'B03', name: 'Bed 01', room: 'Mawar (Kelas 1)', status: BedStatus.occupied, patientName: 'Siti Aminah', admittedDays: 1),
      BedItem(id: 'B04', name: 'Bed 02', room: 'Mawar (Kelas 1)', status: BedStatus.cleaning),
      BedItem(id: 'B05', name: 'Bed 03', room: 'Mawar (Kelas 1)', status: BedStatus.occupied, patientName: 'Budi Darmawan', admittedDays: 5),
      BedItem(id: 'B06', name: 'Bed 04', room: 'Mawar (Kelas 1)', status: BedStatus.maintenance),
      BedItem(id: 'B07', name: 'Bed 01', room: 'Anggrek (Kelas 2)', status: BedStatus.available),
      BedItem(id: 'B08', name: 'Bed 02', room: 'Anggrek (Kelas 2)', status: BedStatus.available),
    ]);
  }
}

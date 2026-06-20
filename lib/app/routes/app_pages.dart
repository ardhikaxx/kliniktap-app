import 'package:get/get.dart';
import 'app_routes.dart';
import '../../features/main_nav/bindings/main_nav_binding.dart';
import '../../features/main_nav/views/main_nav_page.dart';
import '../../features/dashboard/bindings/dashboard_binding.dart';
import '../../features/dashboard/views/dashboard_page.dart';
import '../../features/prescription/bindings/prescription_binding.dart';
import '../../features/prescription/views/prescription_page.dart';
import '../../features/medical_record/bindings/medical_record_detail_binding.dart';
import '../../features/medical_record/views/medical_record_detail_page.dart';

class AppPages {
  static const initial = Routes.mainNav;

  static final routes = [
    GetPage(
      name: Routes.mainNav,
      page: () => const MainNavPage(),
      binding: MainNavBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.prescription,
      page: () => const PrescriptionPage(),
      binding: PrescriptionBinding(),
    ),
    GetPage(
      name: Routes.medicalRecordDetail,
      page: () => const MedicalRecordDetailPage(),
      binding: MedicalRecordDetailBinding(),
    ),
  ];
}

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
import '../../features/queue_list/bindings/queue_list_binding.dart';
import '../../features/queue_list/views/queue_list_page.dart';

import '../../features/notifications/bindings/notifications_binding.dart';
import '../../features/notifications/views/notifications_page.dart';
import '../../features/settings/bindings/settings_binding.dart';
import '../../features/settings/views/settings_page.dart';
import '../../features/queue_detail/bindings/queue_detail_binding.dart';
import '../../features/queue_detail/views/queue_detail_page.dart';
import '../../features/add_medical_record/bindings/add_medical_record_binding.dart';
import '../../features/add_medical_record/views/add_medical_record_page.dart';

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
    GetPage(
      name: Routes.queueList,
      page: () => const QueueListPage(),
      binding: QueueListBinding(),
    ),
    GetPage(
      name: Routes.notifications,
      page: () => const NotificationsPage(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.queueDetail,
      page: () => const QueueDetailPage(),
      binding: QueueDetailBinding(),
    ),
    GetPage(
      name: Routes.addMedicalRecord,
      page: () => const AddMedicalRecordPage(),
      binding: AddMedicalRecordBinding(),
    ),
  ];
}

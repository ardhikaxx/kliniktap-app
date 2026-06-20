import 'package:get/get.dart';
import 'app_routes.dart';

import '../../features/auth/views/splash_page.dart';
import '../../features/auth/views/login_page.dart';
import '../../features/main_nav/views/main_nav_page.dart';
import '../../features/main_nav/bindings/main_nav_binding.dart';
import '../../features/auth/bindings/auth_binding.dart';

import '../../features/patient_dashboard/views/patient_dashboard_page.dart';
import '../../features/patient_polyclinic/views/polyclinic_page.dart';
import '../../features/patient_medical_record/views/patient_medical_record_page.dart';
import '../../features/patient_profile/views/patient_profile_page.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.mainNav,
      page: () => const MainNavPage(),
      binding: MainNavBinding(),
    ),
    GetPage(
      name: Routes.patientDashboard,
      page: () => const PatientDashboardPage(),
    ),
    GetPage(
      name: Routes.patientPolyclinic,
      page: () => const PolyclinicPage(),
    ),
    GetPage(
      name: Routes.patientMedicalRecord,
      page: () => const PatientMedicalRecordPage(),
    ),
    GetPage(
      name: Routes.patientProfile,
      page: () => const PatientProfilePage(),
    ),
  ];
}

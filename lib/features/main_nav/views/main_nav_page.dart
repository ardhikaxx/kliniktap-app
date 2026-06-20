import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_nav_controller.dart';
import '../../dashboard/views/dashboard_page.dart';
import '../../../app/theme/app_colors.dart';
import '../../medical_record/views/medical_record_page.dart';
import '../../schedule_profile/views/schedule_profile_page.dart';

class MainNavPage extends GetView<MainNavController> {
  const MainNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const DashboardPage(),
      const MedicalRecordPage(),
      const ScheduleProfilePage(),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textHint,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dasbor'),
            BottomNavigationBarItem(icon: Icon(Icons.folder_shared), label: 'EMR'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

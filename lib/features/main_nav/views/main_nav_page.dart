import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kliniktap/app/theme/app_text_styles.dart';
import '../controllers/main_nav_controller.dart';
import '../../../app/theme/app_colors.dart';

// Patient Pages
import '../../patient_dashboard/views/patient_dashboard_page.dart';
import '../../patient_polyclinic/views/polyclinic_page.dart';
import '../../patient_medical_record/views/patient_medical_record_page.dart';
import '../../patient_profile/views/patient_profile_page.dart';

class MainNavPage extends GetView<MainNavController> {
  const MainNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const PatientDashboardPage(),
      const PolyclinicPage(),
      const PatientMedicalRecordPage(),
      const PatientProfilePage(),
    ];

    return Scaffold(
      extendBody: true, // Ensures content goes behind the floating nav
      backgroundColor: AppColors.background,
      body: Obx(() {
        // Ensure index doesn't go out of bounds since we reduced to 4 tabs
        final index = controller.currentIndex.value >= pages.length ? 0 : controller.currentIndex.value;
        return IndexedStack(
          index: index,
          children: pages,
        );
      }),
      bottomNavigationBar: Obx(() {
        final index = controller.currentIndex.value >= pages.length ? 0 : controller.currentIndex.value;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(index, 0, Icons.home_rounded, 'Dasbor'),
                  _buildNavItem(index, 1, Icons.business_rounded, 'Poli'),
                  _buildNavItem(index, 2, Icons.monitor_heart_rounded, 'PHR'),
                  _buildNavItem(index, 3, Icons.person_rounded, 'Profil'),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNavItem(int currentIndex, int itemIndex, IconData icon, String label) {
    final isSelected = currentIndex == itemIndex;
    return GestureDetector(
      onTap: () => controller.changeTab(itemIndex),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.primary : AppColors.textHint,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        label,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

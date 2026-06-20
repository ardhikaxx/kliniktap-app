import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/dashboard_sliver_app_bar.dart';
import '../widgets/stat_card.dart';
import '../widgets/queue_list_item.dart';
import '../../../shared/widgets/app_loading_indicator.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppLoadingIndicator();
        }

        final doctor = controller.doctor.value;
        if (doctor == null) return const Center(child: Text('Data tidak ditemukan'));

        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 100, // Space for header
                bottom: 120, // Space for bottom nav
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ikhtisar Hari Ini', style: AppTextStyles.h3),
                          const SizedBox(height: 16),
                          StatCard(
                            label: 'Antrean Pasien',
                            value: doctor.stats.queueToday.toString(),
                            color: AppColors.primary,
                            icon: Icons.people_alt_rounded,
                            isPrimary: true,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: StatCard(
                                  label: 'Resep Diterbitkan',
                                  value: doctor.stats.prescriptionsIssued.toString(),
                                  color: AppColors.secondary,
                                  icon: Icons.receipt_long_rounded,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: StatCard(
                                  label: 'Tugas Selesai',
                                  value: doctor.stats.tasksCompleted.toString(),
                                  color: AppColors.success,
                                  icon: Icons.task_alt_rounded,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Text('Akses Cepat', style: AppTextStyles.h3),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          _buildQuickAction(Icons.calculate_rounded, 'Kalkulator\nMedis', AppColors.primary, () => Get.toNamed('/medical-calculator')),
                          const SizedBox(width: 12),
                          _buildQuickAction(Icons.menu_book_rounded, 'Katalog\nObat', AppColors.secondary, () => Get.toNamed('/drug-catalog')),
                          const SizedBox(width: 12),
                          _buildQuickAction(Icons.people_alt_rounded, 'Tim &\nStaf', const Color(0xFFF5A623), () => Get.toNamed('/staff-management')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Daftar Antrean', style: AppTextStyles.h3),
                          GestureDetector(
                            onTap: () => Get.toNamed('/queue-list'),
                            child: Text(
                              'Lihat Semua',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.queueList.length,
                      itemBuilder: (context, index) {
                        return QueueListItem(patient: controller.queueList[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            // Floating Pill Header
            Positioned(
              top: 0, left: 0, right: 0,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Container(
                    height: 72,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(36),
                      boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 8))],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(doctor.avatarUrl),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Selamat Pagi,',
                                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'dr. ${doctor.name}',
                                style: AppTextStyles.subtitle.copyWith(color: AppColors.textPrimary),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed('/notifications'),
                          child: Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(Icons.notifications_outlined, color: AppColors.textPrimary, size: 22),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Container(
                                    width: 8, height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.error,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 110,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

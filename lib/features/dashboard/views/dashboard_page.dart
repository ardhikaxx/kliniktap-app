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

        return CustomScrollView(
          slivers: [
            DashboardSliverAppBar(doctor: doctor),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12),
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
                          Row(
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final patient = controller.queueList[index];
                    return QueueListItem(patient: patient);
                  },
                  childCount: controller.queueList.length,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

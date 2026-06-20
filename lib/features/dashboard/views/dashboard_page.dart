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
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          StatCard(
                            label: 'Antrean Hari Ini',
                            value: doctor.stats.queueToday.toString(),
                            borderColor: AppColors.primary,
                          ),
                          StatCard(
                            label: 'Resep Diterbitkan',
                            value: doctor.stats.prescriptionsIssued.toString(),
                            borderColor: AppColors.secondary,
                          ),
                          StatCard(
                            label: 'Tugas Selesai',
                            value: doctor.stats.tasksCompleted.toString(),
                            borderColor: AppColors.accent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Daftar Antrean', style: AppTextStyles.h3),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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

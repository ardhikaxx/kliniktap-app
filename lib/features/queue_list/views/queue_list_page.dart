import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/queue_list_controller.dart';
import '../../dashboard/widgets/queue_list_item.dart';
import '../../../shared/widgets/app_loading_indicator.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class QueueListPage extends GetView<QueueListController> {
  const QueueListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
          child: InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18),
            ),
          ),
        ),
        title: Text(
          'Daftar Antrean',
          style: AppTextStyles.h2.copyWith(fontSize: 20, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppLoadingIndicator();
        }

        if (controller.queueList.isEmpty) {
          return Center(
            child: Text(
              'Belum ada antrean saat ini',
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.queueList.length,
          itemBuilder: (context, index) {
            final patient = controller.queueList[index];
            return QueueListItem(patient: patient);
          },
        );
      }),
    );
  }
}

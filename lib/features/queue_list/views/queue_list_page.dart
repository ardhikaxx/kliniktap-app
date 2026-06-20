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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Daftar Antrean',
          style: AppTextStyles.h2.copyWith(fontSize: 18),
        ),
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

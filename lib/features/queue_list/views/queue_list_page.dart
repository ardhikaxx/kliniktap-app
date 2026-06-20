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
      body: Stack(
        children: [
          // Content
          Obx(() {
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
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 90, 
                left: 16, 
                right: 16, 
                bottom: 32,
              ),
              itemCount: controller.queueList.length,
              itemBuilder: (context, index) {
                final patient = controller.queueList[index];
                return QueueListItem(patient: patient);
              },
            );
          }),
          
          // Floating Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Daftar Antrean',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary),
                        ),
                      ),
                      const SizedBox(width: 56), // To balance the space of the left button
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

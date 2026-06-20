import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/schedule_profile_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/app_loading_indicator.dart';

class ScheduleProfilePage extends GetView<ScheduleProfileController> {
  const ScheduleProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profil & Jadwal'),
        elevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppLoadingIndicator();
        }

        final doc = controller.doctor.value;
        if (doc == null) {
          return const Center(child: Text('Gagal memuat profil.'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Header Profil
              Container(
                color: AppColors.surface,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  children: [
                    AppAvatar(imageUrl: doc.avatarUrl, size: 100),
                    const SizedBox(height: 16),
                    Text(doc.name, style: AppTextStyles.h2),
                    const SizedBox(height: 4),
                    Text(doc.specialty, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: doc.isOnline ? AppColors.success.withValues(alpha: 0.1) : AppColors.statusOffline.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: doc.isOnline ? AppColors.success : AppColors.statusOffline,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            doc.isOnline ? 'Sedang Aktif' : 'Tidak Aktif',
                            style: AppTextStyles.caption.copyWith(
                              color: doc.isOnline ? AppColors.success : AppColors.statusOffline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Jadwal Praktik
              Container(
                width: double.infinity,
                color: AppColors.surface,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jadwal Praktik', style: AppTextStyles.h3),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.scheduleDays.length,
                      separatorBuilder: (context, index) => const Divider(height: 24, color: AppColors.divider),
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.scheduleDays[index],
                              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              controller.scheduleHours[index % controller.scheduleHours.length],
                              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              // Tombol Logout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: controller.logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Keluar'),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          ListView.separated(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 90,
              bottom: 40,
              left: 16,
              right: 16,
            ),
            itemCount: 3, // Dummy count
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final isUnread = index == 0;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isUnread ? AppColors.primarySurface : AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isUnread ? AppColors.primary.withValues(alpha: 0.2) : AppColors.border.withValues(alpha: 0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUnread ? AppColors.primary : AppColors.background,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        index == 0 ? Icons.people_alt_rounded : Icons.science_rounded, 
                        color: isUnread ? Colors.white : AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                index == 0 ? 'Pasien Tiba' : 'Hasil Lab Keluar',
                                style: AppTextStyles.subtitle.copyWith(
                                  color: isUnread ? AppColors.primaryDark : AppColors.textPrimary,
                                ),
                              ),
                              Text('10:30 AM', style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            index == 0 
                              ? 'Pasien An. Budi (Antrean #02) telah tiba di ruang tunggu klinik.'
                              : 'Hasil tes darah untuk pasien Siti sudah tersedia dan bisa ditinjau.',
                            style: AppTextStyles.body.copyWith(
                              color: isUnread ? AppColors.textPrimary : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          // Floating Pill Header
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
                          'Pusat Notifikasi',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary),
                        ),
                      ),
                      const SizedBox(width: 56), // Balance
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

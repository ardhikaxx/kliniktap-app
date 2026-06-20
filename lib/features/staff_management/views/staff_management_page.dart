import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/staff_management_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../shared/widgets/app_avatar.dart';

class StaffManagementPage extends GetView<StaffManagementController> {
  const StaffManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final staffs = [
      {'name': 'Ns. Sarah Nabila', 'role': 'Perawat Kepala', 'shift': 'Pagi (08:00 - 15:00)', 'status': 'Aktif', 'img': 'https://i.pravatar.cc/150?u=sarah'},
      {'name': 'Ns. Budi Santoso', 'role': 'Perawat Poli', 'shift': 'Siang (15:00 - 22:00)', 'status': 'Off-Duty', 'img': 'https://i.pravatar.cc/150?u=budi'},
      {'name': 'Ayu Lestari', 'role': 'Admin Klinik', 'shift': 'Pagi (08:00 - 15:00)', 'status': 'Aktif', 'img': 'https://i.pravatar.cc/150?u=ayu'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 90,
              bottom: 40,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tim Klinik', style: AppTextStyles.h2),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: Text('Tambah', style: AppTextStyles.button.copyWith(fontSize: 14)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primarySurface,
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: staffs.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final staff = staffs[index];
                    final isActive = staff['status'] == 'Aktif';
                    
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              AppAvatar(imageUrl: staff['img'] as String, size: 56),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: isActive ? AppColors.success : AppColors.textHint,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(staff['name'] as String, style: AppTextStyles.subtitle),
                                const SizedBox(height: 4),
                                Text(staff['role'] as String, style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time_rounded, size: 14, color: AppColors.textSecondary),
                                    const SizedBox(width: 4),
                                    Text(staff['shift'] as String, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert_rounded, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
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
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 8))],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          width: 48, height: 48,
                          decoration: const BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18),
                        ),
                      ),
                      Expanded(child: Text('Manajemen Staf', textAlign: TextAlign.center, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary))),
                      const SizedBox(width: 56),
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

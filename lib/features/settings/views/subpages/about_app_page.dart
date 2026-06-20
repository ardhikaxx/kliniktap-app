import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10)),
                    ],
                  ),
                  child: const Icon(Icons.medical_services_rounded, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 24),
                Text('KlinikTap', style: AppTextStyles.h1),
                const SizedBox(height: 8),
                Text('Versi 1.0.0 (Build 240620)', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'KlinikTap adalah sistem manajemen klinik cerdas yang dirancang untuk mempercepat alur kerja dokter dan staf. Semua yang Anda butuhkan, di ujung jari Anda.',
                        style: AppTextStyles.body.copyWith(color: AppColors.textPrimary, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: AppColors.border),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.copyright_rounded, size: 16, color: AppColors.textHint),
                          const SizedBox(width: 8),
                          Text('2026 KlinikTap Inc.', style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildFloatingHeader('Tentang Aplikasi'),
        ],
      ),
    );
  }

  Widget _buildFloatingHeader(String title) {
    return Positioned(
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
                Expanded(child: Text(title, textAlign: TextAlign.center, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary))),
                const SizedBox(width: 56),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

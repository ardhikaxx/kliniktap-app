import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';

class TwoFactorAuthPage extends StatelessWidget {
  const TwoFactorAuthPage({super.key});

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
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.security_rounded, size: 80, color: AppColors.primary),
                  const SizedBox(height: 24),
                  Text('Amankan Akun Anda', style: AppTextStyles.h2, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  Text(
                    'Autentikasi dua langkah (2FA) memberikan lapisan keamanan tambahan pada akun Anda dengan mewajibkan kode verifikasi setiap kali Anda masuk.',
                    style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Get.snackbar('Fitur', 'Fitur 2FA segera hadir!', snackPosition: SnackPosition.BOTTOM);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text('Aktifkan 2FA', style: AppTextStyles.button.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          _buildFloatingHeader('Autentikasi 2 Langkah'),
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

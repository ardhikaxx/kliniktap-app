import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kebijakan Privasi', style: AppTextStyles.h2),
                  const SizedBox(height: 8),
                  Text('Terakhir diperbarui: 20 Juni 2026', style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
                  const SizedBox(height: 24),
                  _buildSection('1. Pengumpulan Data', 'Kami mengumpulkan informasi pribadi Anda dan data medis pasien untuk keperluan pelayanan kesehatan di klinik Anda. Seluruh data disimpan dalam server terenkripsi yang memenuhi standar HIPAA.'),
                  const SizedBox(height: 16),
                  _buildSection('2. Penggunaan Data', 'Data yang dikumpulkan hanya digunakan untuk keperluan medis, diagnosis, pembuatan resep, dan rekam medis elektronik.'),
                  const SizedBox(height: 16),
                  _buildSection('3. Keamanan', 'Kami menggunakan enkripsi end-to-end dan sistem keamanan modern untuk memastikan data pasien Anda tidak dapat diakses oleh pihak yang tidak berwenang.'),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                      foregroundColor: AppColors.textPrimary,
                      minimumSize: const Size.fromHeight(50),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: AppColors.border),
                      ),
                    ),
                    child: const Text('Saya Mengerti'),
                  ),
                ],
              ),
            ),
          ),
          _buildFloatingHeader('Kebijakan Privasi'),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.h3),
        const SizedBox(height: 8),
        Text(content, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, height: 1.5)),
      ],
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 90,
              bottom: 40,
              left: 16,
              right: 16,
            ),
            children: [
              _buildFaqItem('Bagaimana cara mengubah profil?', 'Anda dapat mengubah profil melalui halaman Profil dan menekan tombol Edit.'),
              const SizedBox(height: 12),
              _buildFaqItem('Bagaimana cara menambahkan rekam medis?', 'Buka halaman Antrean, pilih pasien, lalu klik "Periksa" untuk mulai menginput data.'),
              const SizedBox(height: 12),
              _buildFaqItem('Bagaimana melihat riwayat pasien?', 'Gunakan menu EMR di navigasi bawah untuk mencari dan melihat riwayat medis pasien secara lengkap.'),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.support_agent_rounded, size: 48, color: AppColors.primary),
                    const SizedBox(height: 16),
                    Text('Butuh Bantuan Lain?', style: AppTextStyles.h3),
                    const SizedBox(height: 8),
                    Text('Tim dukungan kami siap membantu Anda 24/7.', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text('Hubungi Support', style: AppTextStyles.button.copyWith(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildFloatingHeader('Pusat Bantuan'),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: ExpansionTile(
        title: Text(question, style: AppTextStyles.subtitle),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        children: [
          Text(answer, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
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

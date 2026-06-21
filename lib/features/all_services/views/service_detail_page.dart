import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class ServiceDetailPage extends StatelessWidget {
  final String title;
  
  const ServiceDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 110, bottom: 24, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Illustration or Icon
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.medical_information_rounded, size: 80, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 32),
                
                Text('Layanan $title', style: AppTextStyles.h1),
                const SizedBox(height: 16),
                Text(
                  'Ini adalah halaman detail untuk layanan $title. Di sini pasien dapat melihat informasi lengkap mengenai jadwal, persyaratan dokumen pendukung, hingga melakukan reservasi secara online tanpa perlu antre di rumah sakit.',
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, height: 1.5),
                ),
                
                const SizedBox(height: 32),
                
                // Mock Actions
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.calendar_month_rounded, color: AppColors.primary),
                        ),
                        title: Text('Reservasi Jadwal', style: AppTextStyles.subtitle),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textHint),
                        onTap: () {
                          Get.snackbar('Reservasi', 'Memproses permintaan jadwal...', backgroundColor: Colors.white);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.support_agent_rounded, color: Colors.orange),
                        ),
                        title: Text('Hubungi CS Layanan', style: AppTextStyles.subtitle),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textHint),
                        onTap: () {
                          Get.snackbar('Customer Service', 'Menyambungkan ke agen WhatsApp...', backgroundColor: Colors.white);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          _buildFloatingHeader(context, title),
        ],
      ),
    );
  }

  Widget _buildFloatingHeader(BuildContext context, String title) {
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
                IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20), onPressed: () => Get.back()),
                const Spacer(),
                Text(title, style: AppTextStyles.h2.copyWith(fontSize: 18)),
                const Spacer(),
                const SizedBox(width: 48), // Balance for centering
              ],
            ),
          ),
        ),
      ),
    );
  }
}

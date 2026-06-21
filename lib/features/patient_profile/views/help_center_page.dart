import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 110, bottom: 24, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.support_agent_rounded, size: 64, color: Colors.white),
                      const SizedBox(height: 16),
                      Text('Bagaimana kami bisa membantu?', style: AppTextStyles.h2.copyWith(color: Colors.white), textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari topik bantuan...',
                            hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
                            icon: const Icon(Icons.search_rounded, color: AppColors.textHint),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                Text('FAQ (Pertanyaan Umum)', style: AppTextStyles.h2),
                const SizedBox(height: 16),
                
                _buildFaqItem('Cara membatalkan reservasi poli?', 'Anda dapat membatalkan reservasi melalui menu Rekam Medis > Jadwal Mendatang sebelum H-1 jadwal periksa.'),
                _buildFaqItem('Apakah bisa menggunakan BPJS?', 'Ya, KlinikTap terintegrasi dengan PCare BPJS. Pastikan NIK Anda valid dan rujukan aktif.'),
                _buildFaqItem('Di mana saya melihat hasil Lab?', 'Hasil laboratorium akan otomatis muncul di menu Semua Layanan > Hasil Lab setelah divalidasi dokter patologi.'),
                
                const SizedBox(height: 32),
                Text('Hubungi Kami Langsung', style: AppTextStyles.h2),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildContactCard(Icons.chat_bubble_rounded, 'Chat WA', Colors.green),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildContactCard(Icons.phone_in_talk_rounded, 'Call Center', Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          _buildFloatingHeader(context, 'Pusat Bantuan'),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: ExpansionTile(
        title: Text(question, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
        collapsedIconColor: AppColors.primary,
        iconColor: AppColors.primary,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(answer, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, height: 1.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, Color color) {
    return InkWell(
      onTap: () {
        Get.snackbar('Menghubungi...', 'Membuka aplikasi pihak ketiga...', backgroundColor: Colors.white);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(title, style: AppTextStyles.h3),
          ],
        ),
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

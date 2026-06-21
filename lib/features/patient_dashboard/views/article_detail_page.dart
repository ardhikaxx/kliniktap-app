import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class ArticleDetailPage extends StatelessWidget {
  final Map<String, dynamic> article;
  
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 90, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Section
                Container(
                  width: double.infinity,
                  height: 250,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [article['color'] as Color, (article['color'] as Color).withValues(alpha: 0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: (article['color'] as Color).withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20, bottom: -20,
                        child: Icon(article['icon'] as IconData, size: 180, color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                              child: Text(article['category'] as String, style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 16),
                            Text(article['title'] as String, style: AppTextStyles.h1.copyWith(color: Colors.white, fontSize: 24)),
                            const SizedBox(height: 8),
                            Text('Dipublikasikan: Hari ini, 09:00 WIB', style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.8))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Content Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(radius: 20, backgroundColor: AppColors.primarySurface, child: Icon(Icons.edit_document, color: AppColors.primary, size: 20)),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ditinjau oleh dr. Andi Pratama', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                              Text('Tim Medis KlinikTap', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Kesehatan adalah harta yang paling berharga. Melalui artikel ini, kami ingin membagikan informasi penting terkait ${article['title']}.\n\nLangkah pertama yang harus Anda lakukan adalah menjaga pola makan yang seimbang dan berolahraga secara teratur. Hindari konsumsi gula berlebih dan makanan olahan yang berpotensi memicu berbagai penyakit kronis di kemudian hari.\n\nSelain itu, pastikan Anda mendapatkan waktu istirahat yang cukup. Kurang tidur dapat menurunkan sistem kekebalan tubuh, membuat Anda lebih rentan terhadap infeksi virus dan bakteri.\n\nJangan ragu untuk berkonsultasi dengan tim medis kami jika Anda mengalami keluhan yang berkepanjangan. KlinikTap siap melayani Anda 24 jam dengan fasilitas terbaik dan tenaga profesional.',
                        style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, height: 1.8, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildFloatingHeader(context),
        ],
      ),
    );
  }

  Widget _buildFloatingHeader(BuildContext context) {
    return Positioned(
      top: 0, left: 0, right: 0,
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 24, right: 24, bottom: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.background, AppColors.background.withValues(alpha: 0.8), AppColors.background.withValues(alpha: 0.0)]),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 12, offset: const Offset(0, 4))]),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 56,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 8))]),
                child: Center(child: Text('Baca Artikel', style: AppTextStyles.h2.copyWith(fontSize: 18))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

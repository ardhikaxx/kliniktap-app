import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class PdfViewerPage extends StatelessWidget {
  final String title;

  const PdfViewerPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Stack(
        children: [
          // Mock PDF View
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 100, bottom: 40),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 20)],
                ),
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.health_and_safety_rounded, size: 64, color: AppColors.primary),
                    const SizedBox(height: 16),
                    Text('KLINIKTAP HOSPITAL', style: AppTextStyles.h1.copyWith(letterSpacing: 2)),
                    const Divider(color: Colors.black, thickness: 2, height: 32),
                    Text(title, style: AppTextStyles.h2),
                    const SizedBox(height: 24),
                    const Text('DOKUMEN INI ADALAH PRATINJAU PDF HASIL LABORATORIUM / MEDIS. \n\nSemua data divalidasi oleh sistem.'),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const Text('Disahkan oleh,'),
                            const SizedBox(height: 40),
                            const Text('dr. Patologi Klinik'),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          
          // Action Buttons
          Positioned(
            bottom: 40, right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Get.snackbar('Berhasil', 'Dokumen PDF telah diunduh ke perangkat Anda.', backgroundColor: AppColors.success, colorText: Colors.white);
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.download_rounded, color: Colors.white),
            ),
          ),

          // Header
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
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20), onPressed: () => Get.back()),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text('$title.pdf', style: AppTextStyles.h3, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
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

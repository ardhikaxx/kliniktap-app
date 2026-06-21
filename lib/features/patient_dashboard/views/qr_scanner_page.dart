import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Get.back();
        Get.snackbar(
          'Check-In Berhasil',
          'Anda telah terkonfirmasi hadir di KlinikTap. Silakan menuju ruang tunggu.',
          backgroundColor: AppColors.success,
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Text('Membuka Kamera...', style: AppTextStyles.body.copyWith(color: Colors.white54)),
          ),
          ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcOut),
            child: Stack(
              children: [
                Container(decoration: const BoxDecoration(color: Colors.transparent, backgroundBlendMode: BlendMode.dstOut)),
                Center(
                  child: Container(
                    width: 250, height: 250,
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(border: Border.all(color: AppColors.primary, width: 2), borderRadius: BorderRadius.circular(24)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Positioned(
                          top: _animationController.value * 246,
                          left: 0, right: 0,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.8), blurRadius: 10, spreadRadius: 2)],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100, left: 20, right: 20,
            child: Column(
              children: [
                const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 48),
                const SizedBox(height: 16),
                Text('Arahkan kamera ke QR Code', style: AppTextStyles.h2.copyWith(color: Colors.white)),
                const SizedBox(height: 8),
                Text('Pindai QR Code di mesin KiosK Rumah Sakit untuk melakukan Check-In mandiri.', style: AppTextStyles.body.copyWith(color: Colors.white70), textAlign: TextAlign.center),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16, left: 16,
            child: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close_rounded, color: Colors.white, size: 32)),
          ),
        ],
      ),
    );
  }
}

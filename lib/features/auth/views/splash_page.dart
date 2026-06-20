import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class SplashPage extends GetView<AuthController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize splash timer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initSplash();
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 40, offset: const Offset(0, 20)),
                ],
              ),
              child: const Icon(Icons.medical_services_rounded, color: Colors.white, size: 60),
            ),
            const SizedBox(height: 32),
            Text(
              'KlinikTap',
              style: AppTextStyles.h1.copyWith(fontSize: 32, letterSpacing: -1),
            ),
            const SizedBox(height: 8),
            Text('Aplikasi Pasien Rumah Sakit', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
            
            const SizedBox(height: 64),
            const CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

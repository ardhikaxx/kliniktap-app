import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class PatientLoginPage extends StatelessWidget {
  const PatientLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 32),
              
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.badge_rounded, size: 48, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              Text('Portal Pasien', style: AppTextStyles.h1.copyWith(fontSize: 32)),
              const SizedBox(height: 8),
              Text('Akses rekam medis, antrean poli, dan telekonsultasi dalam satu genggaman yang terintegrasi BPJS & SATUSEHAT.', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, height: 1.5)),
              
              const SizedBox(height: 48),
              
              // NIK Input
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 24, offset: const Offset(0, 12))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nomor Induk Kependudukan (NIK)', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: AppTextStyles.body.copyWith(fontSize: 18, letterSpacing: 2),
                        maxLength: 16,
                        decoration: InputDecoration(
                          hintText: '16 Digit NIK KTP Anda',
                          hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint, letterSpacing: 0),
                          prefixIcon: const Icon(Icons.credit_card_rounded, color: AppColors.textSecondary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          counterText: '',
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    ElevatedButton(
                      onPressed: () => Get.offAllNamed('/patient-dashboard'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size.fromHeight(60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 4,
                      ),
                      child: Text('Masuk dengan FaceID / Sidik Jari', style: AppTextStyles.button.copyWith(color: Colors.white, fontSize: 16)),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Belum terdaftar di Rumah Sakit? ',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                    children: [
                      TextSpan(
                        text: 'Daftar Baru',
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

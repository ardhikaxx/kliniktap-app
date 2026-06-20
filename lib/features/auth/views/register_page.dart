import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.person_add_rounded, size: 48, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              Text('Pendaftaran Pasien Baru', style: AppTextStyles.h1.copyWith(fontSize: 32, height: 1.2)),
              const SizedBox(height: 8),
              Text('Lengkapi data diri Anda sesuai KTP/KK untuk terhubung dengan sistem rumah sakit & BPJS Kesehatan.', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, height: 1.5)),
              
              const SizedBox(height: 40),
              
              // Registration Form
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
                    _buildInputField('Nomor Induk Kependudukan (NIK)', '16 Digit Angka NIK', Icons.credit_card_rounded, TextInputType.number),
                    const SizedBox(height: 20),
                    _buildInputField('Nama Lengkap', 'Sesuai KTP', Icons.person_rounded, TextInputType.name),
                    const SizedBox(height: 20),
                    _buildInputField('Tanggal Lahir', 'DD/MM/YYYY', Icons.calendar_month_rounded, TextInputType.datetime),
                    const SizedBox(height: 20),
                    _buildInputField('Nomor Telepon / WhatsApp', 'Mulai dengan 08...', Icons.phone_android_rounded, TextInputType.phone),
                    
                    const SizedBox(height: 32),
                    
                    ElevatedButton(
                      onPressed: () {
                        Get.snackbar(
                          'Pendaftaran Berhasil',
                          'Data Anda telah divalidasi oleh sistem Dukcapil. Silakan login.',
                          backgroundColor: AppColors.success,
                          colorText: Colors.white,
                          icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
                          margin: const EdgeInsets.all(16),
                          snackPosition: SnackPosition.TOP,
                        );
                        Future.delayed(const Duration(seconds: 2), () {
                          Get.offAllNamed('/login');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size.fromHeight(60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 4,
                      ),
                      child: Text('Daftar Sekarang', style: AppTextStyles.button.copyWith(color: Colors.white, fontSize: 18)),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, IconData icon, TextInputType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            keyboardType: type,
            style: AppTextStyles.body.copyWith(fontSize: 16),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
              prefixIcon: Icon(icon, color: AppColors.textSecondary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}

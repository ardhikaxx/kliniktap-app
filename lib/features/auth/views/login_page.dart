import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Elements
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.1),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10)),
                      ],
                    ),
                    child: const Icon(Icons.medical_services_rounded, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 32),
                  
                  // Welcome Text
                  Text('Selamat Datang!', style: AppTextStyles.h1.copyWith(fontSize: 32)),
                  const SizedBox(height: 8),
                  Text('Masuk untuk mengakses dasbor klinik Anda.', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                  
                  const SizedBox(height: 48),
                  
                  // Form Container
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 24, offset: const Offset(0, 12)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email Field
                        Text('Alamat Email', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                          ),
                          child: TextField(
                            style: AppTextStyles.body,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'dokter@kliniktap.com',
                              hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
                              prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textSecondary),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Password Field
                        Text('Kata Sandi', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                          ),
                          child: TextField(
                            obscureText: true,
                            style: AppTextStyles.body,
                            decoration: InputDecoration(
                              hintText: '••••••••',
                              hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
                              prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textSecondary),
                              suffixIcon: const Icon(Icons.visibility_off_outlined, color: AppColors.textSecondary),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        
                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Lupa Kata Sandi?', style: AppTextStyles.button.copyWith(color: AppColors.primary)),
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Login Button
                        Obx(() => ElevatedButton(
                          onPressed: controller.isLoading.value ? null : controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size.fromHeight(60),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 4,
                            shadowColor: AppColors.primary.withValues(alpha: 0.4),
                          ),
                          child: controller.isLoading.value 
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : Text('Masuk', style: AppTextStyles.button.copyWith(color: Colors.white, fontSize: 18)),
                        )),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Biometric Login
                  Center(
                    child: Column(
                      children: [
                        Text('Atau masuk lebih cepat dengan', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: controller.login, // trigger the same login for dummy
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                              boxShadow: [
                                BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 16, offset: const Offset(0, 8)),
                              ],
                            ),
                            child: const Icon(Icons.fingerprint_rounded, color: AppColors.primary, size: 32),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Patient Portal Redirect
                  Center(
                    child: Column(
                      children: [
                        Text('Bukan Tenaga Medis?', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => Get.toNamed('/patient-login'),
                          icon: const Icon(Icons.person_outline_rounded),
                          label: const Text('Akses Portal Pasien Umum'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary, width: 2),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import 'video_call_page.dart';

class TeleconsultationPage extends StatelessWidget {
  const TeleconsultationPage({super.key});

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
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFD97706)]),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.video_camera_front_rounded, size: 48, color: Colors.white),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Konsultasi Kapan Saja', style: AppTextStyles.h3.copyWith(color: Colors.white)),
                            const SizedBox(height: 4),
                            Text('Tanya dokter dari rumah dengan video call HD.', style: AppTextStyles.caption.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                Text('Dokter Tersedia Online', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                const SizedBox(height: 16),
                
                _buildDoctorCard('dr. Sarah Maida, Sp.A', 'Dokter Anak', '4.9', 'Tersedia', true),
                _buildDoctorCard('dr. Budi Santoso, Sp.PD', 'Penyakit Dalam', '4.8', 'Sedang Konsultasi', false),
                _buildDoctorCard('dr. Clara Tania, Sp.KK', 'Kulit & Kelamin', '5.0', 'Tersedia', true),
              ],
            ),
          ),
          
          // Floating Header
          _buildFloatingHeader(context, 'Telekonsultasi'),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String spec, String rating, String status, bool isOnline) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(radius: 28, backgroundColor: AppColors.primarySurface, child: Icon(Icons.person, color: AppColors.primary)),
              Positioned(
                right: 0, bottom: 0,
                child: Container(width: 14, height: 14, decoration: BoxDecoration(color: isOnline ? AppColors.success : AppColors.warning, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2))),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.subtitle),
                const SizedBox(height: 4),
                Text(spec, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: AppColors.accent, size: 16),
                    const SizedBox(width: 4),
                    Text(rating, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 12),
                    Text(status, style: AppTextStyles.caption.copyWith(color: isOnline ? AppColors.success : AppColors.warning)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => const VideoCallPage());
            },
            style: IconButton.styleFrom(backgroundColor: AppColors.primarySurface),
            icon: const Icon(Icons.call_rounded, color: AppColors.primary),
          ),
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

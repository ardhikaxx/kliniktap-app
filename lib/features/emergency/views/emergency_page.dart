import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF2F2), // Light red background
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SOS Button (Giant)
                GestureDetector(
                  onTap: () {
                    Get.snackbar('Ambulans Dipanggil', 'Sistem melacak lokasi Anda. Tim darurat segera meluncur.', backgroundColor: AppColors.error, colorText: Colors.white, icon: const Icon(Icons.airport_shuttle_rounded, color: Colors.white));
                  },
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.error,
                      boxShadow: [
                        BoxShadow(color: AppColors.error.withValues(alpha: 0.4), blurRadius: 40, spreadRadius: 10),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.sos_rounded, size: 80, color: Colors.white),
                          const SizedBox(height: 8),
                          Text('TEKAN DARURAT', style: AppTextStyles.subtitle.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Text('Panggilan Cepat', style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildQuickAction(Icons.local_hospital_rounded, 'Ambulans', '118'),
                    const SizedBox(width: 24),
                    _buildQuickAction(Icons.local_police_rounded, 'Polisi', '110'),
                  ],
                ),
              ],
            ),
          ),
          
          _buildFloatingHeader(context, 'IGD & Darurat'),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String title, String number) {
    return Column(
      children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)]),
          child: Icon(icon, size: 32, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        Text(title, style: AppTextStyles.subtitle),
        Text(number, style: AppTextStyles.caption.copyWith(color: AppColors.error, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildFloatingHeader(BuildContext context, String title) {
    return Positioned(
      top: 0, left: 0, right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: const Color(0xFFFEF2F2).withValues(alpha: 0.85),
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, bottom: 12, left: 8, right: 20),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20), onPressed: () => Get.back()),
                Text(title, style: AppTextStyles.h2.copyWith(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

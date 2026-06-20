import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class AllServicesPage extends StatelessWidget {
  const AllServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 80, bottom: 24, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kategori Layanan', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                const SizedBox(height: 16),
                _buildServiceCategory('Medis & Perawatan', Icons.medical_services_rounded, ['Reservasi Poli', 'Telekonsultasi', 'Rawat Inap', 'Home Care']),
                _buildServiceCategory('Penunjang Medis', Icons.science_rounded, ['Laboratorium', 'Radiologi', 'Fisioterapi', 'Bank Darah']),
                _buildServiceCategory('Administrasi', Icons.assignment_rounded, ['Tagihan RS', 'Asuransi & BPJS', 'Rekam Medis', 'Pusat Bantuan']),
              ],
            ),
          ),
          
          _buildFloatingHeader(context, 'Semua Layanan'),
        ],
      ),
    );
  }

  Widget _buildServiceCategory(String title, IconData icon, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Text(title, style: AppTextStyles.subtitle.copyWith(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10)]),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: items.length,
              separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.border),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  title: Text(items[index], style: AppTextStyles.body),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textHint),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingHeader(BuildContext context, String title) {
    return Positioned(
      top: 0, left: 0, right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withValues(alpha: 0.85),
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

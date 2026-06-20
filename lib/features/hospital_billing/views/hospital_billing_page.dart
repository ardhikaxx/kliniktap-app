import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class HospitalBillingPage extends StatelessWidget {
  const HospitalBillingPage({super.key});

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
                _buildBillingCard('INV-202310-992', 'Pemeriksaan Poli Dalam', 'Rp 150.000', 'Belum Lunas', false),
                _buildBillingCard('INV-202309-102', 'Penebusan Resep Obat', 'Rp 85.000', 'Lunas', true),
                _buildBillingCard('INV-202308-045', 'Tes Darah Lengkap', 'Rp 320.000', 'Lunas', true),
              ],
            ),
          ),
          
          _buildFloatingHeader(context, 'Tagihan Rumah Sakit'),
        ],
      ),
    );
  }

  Widget _buildBillingCard(String inv, String desc, String amount, String status, bool isPaid) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(inv, style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: isPaid ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(status, style: AppTextStyles.caption.copyWith(color: isPaid ? AppColors.success : AppColors.error, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(desc, style: AppTextStyles.subtitle),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(amount, style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
              if (!isPaid)
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text('Bayar', style: TextStyle(color: Colors.white)),
                )
              else
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_rounded, size: 16),
                  label: const Text('Kwitansi'),
                )
            ],
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

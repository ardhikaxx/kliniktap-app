import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

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
                // Total Tagihan
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  child: Column(
                    children: [
                      Text('Total Pembayaran', style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.8))),
                      const SizedBox(height: 8),
                      Text('Rp 2.450.000', style: AppTextStyles.h1.copyWith(color: Colors.white, fontSize: 36)),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                        child: Text('Batas Waktu: 23:59:59', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                Text('Pilih Metode Pembayaran', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                const SizedBox(height: 16),
                
                _buildPaymentMethod('Virtual Account BCA', 'Biaya Admin: Rp 1.000', Icons.account_balance_rounded, Colors.blue),
                _buildPaymentMethod('Virtual Account Mandiri', 'Biaya Admin: Rp 1.000', Icons.account_balance_rounded, Colors.amber.shade700),
                _buildPaymentMethod('QRIS', 'Bebas Biaya Admin', Icons.qr_code_scanner_rounded, Colors.red),
                _buildPaymentMethod('Asuransi Swasta / BPJS', 'Diverifikasi secara manual', Icons.health_and_safety_rounded, AppColors.success),
              ],
            ),
          ),
          
          _buildFloatingHeader(context, 'Pembayaran'),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: AppTextStyles.h3.copyWith(fontSize: 16)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
        onTap: () {
          Get.bottomSheet(
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 24),
                    Icon(icon, size: 64, color: color),
                    const SizedBox(height: 16),
                    Text(title, style: AppTextStyles.h2),
                    const SizedBox(height: 8),
                    Text('Menunggu konfirmasi sistem gateway...', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.snackbar(
                            'Pembayaran Diterima',
                            'Terima kasih, pembayaran untuk tagihan ini telah lunas.',
                            backgroundColor: AppColors.success,
                            colorText: Colors.white,
                            icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text('Simulasi Bayar Berhasil', style: AppTextStyles.button.copyWith(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isScrollControlled: true,
          );
        },
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

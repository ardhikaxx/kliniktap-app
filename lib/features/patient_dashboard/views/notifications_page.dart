import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {'title': 'Pembayaran Berhasil', 'desc': 'Pembayaran tagihan obat senilai Rp 150.000 telah terverifikasi.', 'time': '10 menit yang lalu', 'icon': Icons.check_circle_rounded, 'color': AppColors.success},
      {'title': 'Hasil Lab Tersedia', 'desc': 'Hasil tes Darah Lengkap Anda sudah dapat diunduh.', 'time': '2 jam yang lalu', 'icon': Icons.science_rounded, 'color': AppColors.primary},
      {'title': 'Pengingat Konsultasi', 'desc': 'Jangan lupa jadwal konsultasi Anda dengan dr. Andi Pratama besok pukul 10:00.', 'time': '1 hari yang lalu', 'icon': Icons.calendar_month_rounded, 'color': AppColors.warning},
      {'title': 'Selamat Datang di KlinikTap', 'desc': 'Akun Anda berhasil didaftarkan. Nikmati kemudahan layanan kesehatan dalam satu genggaman.', 'time': '3 hari yang lalu', 'icon': Icons.celebration_rounded, 'color': AppColors.secondary},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 110, bottom: 24, left: 24, right: 24),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: (notif['color'] as Color).withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: Icon(notif['icon'] as IconData, color: notif['color'] as Color),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notif['title'], style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(notif['desc'], style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                          const SizedBox(height: 8),
                          Text(notif['time'], style: AppTextStyles.caption.copyWith(color: AppColors.textHint, fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          _buildFloatingHeader(context),
        ],
      ),
    );
  }

  Widget _buildFloatingHeader(BuildContext context) {
    return Positioned(
      top: 0, left: 0, right: 0,
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 24, right: 24, bottom: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.background, AppColors.background.withValues(alpha: 0.8), AppColors.background.withValues(alpha: 0.0)]),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 12, offset: const Offset(0, 4))]),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 56,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 8))]),
                child: Center(child: Text('Notifikasi', style: AppTextStyles.h2.copyWith(fontSize: 18))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

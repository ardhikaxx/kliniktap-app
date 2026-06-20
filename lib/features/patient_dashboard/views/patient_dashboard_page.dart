import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class PatientDashboardPage extends StatelessWidget {
  const PatientDashboardPage({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat Pagi';
    if (hour < 15) return 'Selamat Siang';
    if (hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Dynamic Background Element
          Positioned(
            top: -150,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 90,
              bottom: 120, // Extra space for nav bar
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Digital Health Card (Premium Look)
                _buildDigitalHealthCard(),
                
                const SizedBox(height: 36),
                
                // Section Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Layanan Utama', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                    Icon(Icons.more_horiz_rounded, color: AppColors.textHint),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Premium Grid Services
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.8,
                  children: [
                    _buildIconService(Icons.domain_verification_rounded, 'Reservasi\nPoli', const Color(0xFF3B82F6)),
                    _buildIconService(Icons.monitor_heart_rounded, 'Rekam\nMedis', const Color(0xFF10B981)),
                    _buildIconService(Icons.video_camera_front_rounded, 'Tele\nKonsul', const Color(0xFFF59E0B)),
                    _buildIconService(Icons.receipt_long_rounded, 'Tagihan\nRS', const Color(0xFF8B5CF6)),
                    _buildIconService(Icons.medical_services_rounded, 'Farmasi', const Color(0xFFEC4899)),
                    _buildIconService(Icons.science_rounded, 'Hasil\nLab', const Color(0xFF14B8A6)),
                    _buildIconService(Icons.emergency_rounded, 'IGD\nDarurat', const Color(0xFFEF4444)),
                    _buildIconService(Icons.grid_view_rounded, 'Semua\nMenu', AppColors.textSecondary),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Active Queue (Boarding Pass Style)
                Text('Antrean Aktif Saat Ini', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                const SizedBox(height: 16),
                _buildActiveQueueTicket(),
              ],
            ),
          ),
          
          // Glassmorphism Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withValues(alpha: 0.8),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 12,
                    bottom: 12,
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primarySurface,
                          child: Text('BS', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${_getGreeting()},', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                            Text('Budi Santoso', style: AppTextStyles.subtitle.copyWith(color: AppColors.textPrimary)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: IconButton(
                          onPressed: () => Get.offAllNamed('/login'),
                          icon: const Icon(Icons.logout_rounded, color: AppColors.textSecondary, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitalHealthCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF0A585B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Abstract Card Design Elements
          Positioned(
            right: -30,
            top: -20,
            child: Icon(Icons.medical_services_rounded, size: 120, color: Colors.white.withValues(alpha: 0.05)),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified_rounded, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text('BPJS AKTIF', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Icon(Icons.contactless_rounded, color: Colors.white, size: 24),
                ],
              ),
              const SizedBox(height: 32),
              Text('Nomor Rekam Medis (RM)', style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.8))),
              const SizedBox(height: 4),
              Text('RM-8820-192', style: AppTextStyles.h1.copyWith(color: Colors.white, letterSpacing: 2, fontSize: 24)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pasien', style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.8))),
                      Text('BUDI SANTOSO', style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/SatuSehat_Logo.png/800px-SatuSehat_Logo.png',
                    height: 24,
                    color: Colors.white,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.health_and_safety_rounded, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconService(IconData icon, String title, Color color) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveQueueTicket() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.access_time_filled_rounded, color: AppColors.warning),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Poli Penyakit Dalam', style: AppTextStyles.h3),
                          Text('A-12', style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('dr. Yanuar Ardhika R.U, Sp.PD', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.people_alt_rounded, size: 16, color: AppColors.textHint),
                          const SizedBox(width: 6),
                          Text('2 antrean di depan Anda', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Dashed Divider
          Row(
            children: [
              SizedBox(
                height: 20,
                width: 10,
                child: DecoratedBox(decoration: BoxDecoration(color: AppColors.background, borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)))),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(
                          (constraints.constrainWidth() / 8).floor(),
                          (index) => SizedBox(width: 4, height: 1.5, child: DecoratedBox(decoration: BoxDecoration(color: AppColors.border))),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                width: 10,
                child: DecoratedBox(decoration: BoxDecoration(color: AppColors.background, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)))),
              ),
            ],
          ),
          
          // Bottom Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Estimasi Panggil', style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
                    Text('10:45 WIB', style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.snackbar(
                      'Check-In Berhasil',
                      'Lokasi Anda telah diverifikasi oleh sistem antrean.',
                      backgroundColor: AppColors.success,
                      colorText: Colors.white,
                      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
                      margin: const EdgeInsets.all(16),
                    );
                  },
                  icon: const Icon(Icons.qr_code_scanner_rounded, size: 20),
                  label: const Text('Check-In RS'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

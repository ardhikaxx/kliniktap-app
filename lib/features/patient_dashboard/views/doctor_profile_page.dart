import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class DoctorProfilePage extends StatelessWidget {
  final Map<String, dynamic> doctor;
  
  const DoctorProfilePage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 90, bottom: 24, left: 24, right: 24),
            child: Column(
              children: [
                // Profile Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.primarySurface,
                            child: Icon(Icons.person_rounded, size: 60, color: AppColors.primary),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(Icons.verified_rounded, color: AppColors.success, size: 28),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(doctor['name'], style: AppTextStyles.h2.copyWith(fontSize: 22), textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      Text('Spesialis ', style: AppTextStyles.subtitle.copyWith(color: AppColors.primary)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildStatItem(Icons.star_rounded, doctor['rating'], 'Rating', AppColors.warning),
                          Container(width: 1, height: 40, color: AppColors.border, margin: const EdgeInsets.symmetric(horizontal: 16)),
                          _buildStatItem(Icons.work_history_rounded, '10 Thn', 'Pengalaman', AppColors.secondary),
                          Container(width: 1, height: 40, color: AppColors.border, margin: const EdgeInsets.symmetric(horizontal: 16)),
                          _buildStatItem(Icons.people_alt_rounded, '2rb+', 'Pasien', AppColors.success),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // About Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tentang Dokter', style: AppTextStyles.h3),
                      const SizedBox(height: 12),
                      Text(
                        ' adalah dokter spesialis  yang berdedikasi tinggi dengan pengalaman lebih dari 10 tahun di Rumah Sakit Pusat. Beliau aktif dalam berbagai seminar kesehatan nasional dan internasional.',
                        style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, height: 1.5),
                      ),
                      const SizedBox(height: 24),
                      Text('Jadwal Praktik', style: AppTextStyles.h3),
                      const SizedBox(height: 12),
                      _buildScheduleItem('Senin - Rabu', '09:00 - 14:00 WIB'),
                      _buildScheduleItem('Kamis - Jumat', '13:00 - 18:00 WIB'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildFloatingHeader(context),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -5))],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Get.toNamed('/teleconsultation'),
                  icon: const Icon(Icons.video_camera_front_rounded),
                  label: const Text('Telekonsultasi'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    side: BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.snackbar(
                      'Buat Janji Berhasil',
                      'Anda telah didaftarkan pada antrean terdekat. Silakan cek menu Reservasi Poli.',
                      backgroundColor: AppColors.success,
                      colorText: Colors.white,
                      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
                      snackPosition: SnackPosition.TOP,
                    );
                  },
                  icon: const Icon(Icons.calendar_month_rounded),
                  label: const Text('Buat Janji'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyles.h3),
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
      ],
    );
  }

  Widget _buildScheduleItem(String day, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.event_available_rounded, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(day, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold))),
          Text(time, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
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
                child: Center(child: Text('Profil Dokter', style: AppTextStyles.h2.copyWith(fontSize: 18))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class DoctorSelectionPage extends StatelessWidget {
  final String departmentName;

  const DoctorSelectionPage({super.key, required this.departmentName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 110, bottom: 24, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Jadwal terintegrasi langsung dengan Mobile JKN dan antrean RS realtime.',
                          style: AppTextStyles.caption.copyWith(color: AppColors.primaryDark),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                Text('Dokter Tersedia', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                const SizedBox(height: 16),
                
                _buildDoctorCard(
                  name: 'dr. Yanuar Ardhika R.U, Sp.PD',
                  specialty: 'Spesialis Penyakit Dalam',
                  rating: '4.9',
                  patients: '1.2k+ Pasien',
                  availability: 'Hari ini, 09:00 - 14:00',
                  color: Colors.blue,
                ),
                _buildDoctorCard(
                  name: 'dr. Sarah Maida, Sp.PD-KGEH',
                  specialty: 'Konsultan Gastroenterohepatologi',
                  rating: '5.0',
                  patients: '800+ Pasien',
                  availability: 'Hari ini, 15:00 - 20:00',
                  color: Colors.teal,
                ),
                _buildDoctorCard(
                  name: 'dr. Budi Santoso, Sp.PD',
                  specialty: 'Spesialis Penyakit Dalam',
                  rating: '4.8',
                  patients: '2.1k+ Pasien',
                  availability: 'Besok, 08:00 - 12:00',
                  color: Colors.indigo,
                ),
              ],
            ),
          ),
          
          _buildFloatingHeader(context, 'Poli $departmentName'),
        ],
      ),
    );
  }

  Widget _buildDoctorCard({
    required String name,
    required String specialty,
    required String rating,
    required String patients,
    required String availability,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Get.snackbar(
              'Reservasi Tiket',
              'Membuat nomor antrean untuk $name...',
              backgroundColor: AppColors.success,
              colorText: Colors.white,
              icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.person_rounded, color: color, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: AppTextStyles.h3.copyWith(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(specialty, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: AppColors.accent, size: 16),
                              const SizedBox(width: 4),
                              Text(rating, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 16),
                              const Icon(Icons.people_alt_rounded, color: AppColors.textHint, size: 16),
                              const SizedBox(width: 4),
                              Text(patients, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded, color: AppColors.textSecondary, size: 16),
                        const SizedBox(width: 8),
                        Text(availability, style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('Pilih', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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

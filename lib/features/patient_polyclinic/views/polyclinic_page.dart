import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class PolyclinicPage extends StatelessWidget {
  const PolyclinicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 110,
              bottom: 100,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pilih berdasarkan Spesialisasi', style: AppTextStyles.h3),
                const SizedBox(height: 16),
                _buildDepartmentCard(
                  'Penyakit Dalam Khusus',
                  'Hematologi, Gastroentero, Reumatologi',
                  Icons.monitor_heart_rounded,
                  Colors.red,
                ),
                _buildDepartmentCard(
                  'Bedah Terpadu',
                  'Bedah Saraf, Thorak, Plastik, Ortopedi',
                  Icons.content_cut_rounded,
                  Colors.orange,
                ),
                _buildDepartmentCard(
                  'Kesehatan Ibu & Anak',
                  'Obgyn, Fetomaternal, Perinatologi',
                  Icons.pregnant_woman_rounded,
                  Colors.pink,
                ),
                _buildDepartmentCard(
                  'Indrawi & Maksilofasial',
                  'Rinologi, THT, Bedah Mulut, Mata',
                  Icons.remove_red_eye_rounded,
                  Colors.blue,
                ),
                _buildDepartmentCard(
                  'Pernapasan & Jantung',
                  'Respirologi, TB Terpadu, Kardiovaskular',
                  Icons.air_rounded,
                  Colors.teal,
                ),
              ],
            ),
          ),
          
          // Floating Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 8))],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari poliklinik atau gejala...',
                            hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
                            border: InputBorder.none,
                          ),
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

  Widget _buildDepartmentCard(String title, String subtitle, IconData icon, Color color) {
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
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: AppTextStyles.h3.copyWith(fontSize: 16)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
        onTap: () {
          Get.snackbar('Reservasi', 'Memeriksa integrasi jadwal BPJS Antrol v2...', backgroundColor: Colors.white);
        },
      ),
    );
  }
}

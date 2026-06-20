import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class PatientMedicalRecordPage extends StatelessWidget {
  const PatientMedicalRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 90,
              bottom: 100,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.security_rounded, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Data Rekam Medis Elektronik (RME) ini terenkripsi end-to-end dan disinkronisasi langsung dengan platform SATUSEHAT Kementerian Kesehatan RI.',
                          style: AppTextStyles.caption.copyWith(color: AppColors.primaryDark),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // FHIR: Condition (Diagnosis & Alergi)
                Text('Riwayat Klinis & Alergi', style: AppTextStyles.h2),
                const SizedBox(height: 16),
                _buildTimelineItem(
                  'Alergi Obat',
                  'Amoxicillin (Reaksi: Ruam Kulit)',
                  Icons.warning_amber_rounded,
                  Colors.red,
                  'Disahkan: 12 Jan 2024',
                ),
                _buildTimelineItem(
                  'Diagnosa Aktif (ICD-10)',
                  'E11.9 - Diabetes mellitus tipe 2',
                  Icons.medical_information_rounded,
                  AppColors.primary,
                  'Update: 05 Jun 2026',
                ),

                const SizedBox(height: 24),
                
                // FHIR: Observation & ImagingStudy
                Text('Hasil Laboratorium & Radiologi', style: AppTextStyles.h2),
                const SizedBox(height: 16),
                _buildTimelineItem(
                  'Tes Darah Rutin (LOINC)',
                  'Gula Darah Puasa: 140 mg/dL (Tinggi)',
                  Icons.bloodtype_rounded,
                  Colors.orange,
                  '05 Jun 2026 - Lab Sentral',
                ),
                _buildTimelineItem(
                  'Rontgen Thorax (DICOM)',
                  'Tidak tampak kelainan paru.',
                  Icons.co2_rounded,
                  Colors.teal,
                  '12 Jan 2024 - Radiologi',
                ),

                const SizedBox(height: 24),
                
                // FHIR: MedicationRequest (Resep)
                Text('Riwayat Peresepan Obat', style: AppTextStyles.h2),
                const SizedBox(height: 16),
                _buildTimelineItem(
                  'Metformin 500mg',
                  '3 x Sehari (Sesudah Makan) - 30 Tablet',
                  Icons.medication_rounded,
                  AppColors.secondary,
                  'Diresepkan oleh dr. Yanuar Ardhika',
                ),
              ],
            ),
          ),
          
          // Floating Pill Header
          Positioned(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.folder_shared_rounded, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text('Rekam Medis (PHR)', style: AppTextStyles.h2.copyWith(fontSize: 18)),
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

  Widget _buildTimelineItem(String title, String desc, IconData icon, Color color, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(desc, style: AppTextStyles.h3.copyWith(fontSize: 15)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.verified_rounded, size: 14, color: AppColors.success),
                    const SizedBox(width: 4),
                    Text(time, style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

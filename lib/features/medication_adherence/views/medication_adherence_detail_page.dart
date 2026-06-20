import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/medication_adherence_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class MedicationAdherenceDetailPage extends StatelessWidget {
  const MedicationAdherenceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MedicationPatient patient = Get.arguments;

    Color progressColor;
    if (patient.adherencePercentage >= 80) progressColor = AppColors.success;
    else if (patient.adherencePercentage >= 50) progressColor = AppColors.warning;
    else progressColor = AppColors.error;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 100,
              bottom: 40,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                          border: Border.all(color: progressColor, width: 3),
                        ),
                        child: Center(
                          child: Text('${patient.adherencePercentage}%', style: AppTextStyles.h3.copyWith(color: progressColor)),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(patient.name, style: AppTextStyles.h2.copyWith(fontSize: 20)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primarySurface,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(patient.disease, style: AppTextStyles.caption.copyWith(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                Text('Daftar Resep Aktif', style: AppTextStyles.h3),
                const SizedBox(height: 12),
                
                // Medicines
                _buildMedicineCard('Amlodipine 10mg', '1 x Sehari (Pagi)', true),
                const SizedBox(height: 12),
                _buildMedicineCard('Metformin 500mg', '2 x Sehari (Sesudah Makan)', false),

                const SizedBox(height: 32),
                Text('Log Minum Obat Minggu Ini', style: AppTextStyles.h3),
                const SizedBox(height: 16),
                
                // Calendar Log
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDayLog('Sen', true),
                      _buildDayLog('Sel', true),
                      _buildDayLog('Rab', false),
                      _buildDayLog('Kam', true),
                      _buildDayLog('Jum', true),
                      _buildDayLog('Sab', null), // Not yet happened
                      _buildDayLog('Min', null),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.snackbar('Notifikasi', 'Pengingat berhasil dikirim ke WhatsApp pasien', backgroundColor: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Kirim Pengingat Manual (WhatsApp)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
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
                    children: [
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          width: 48, height: 48,
                          decoration: const BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18),
                        ),
                      ),
                      Expanded(child: Text('Detail Kepatuhan', textAlign: TextAlign.center, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary))),
                      const SizedBox(width: 56),
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

  Widget _buildMedicineCard(String name, String dosage, bool isTakenToday) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.medication_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.h3.copyWith(fontSize: 16)),
                const SizedBox(height: 4),
                Text(dosage, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isTakenToday ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(isTakenToday ? 'Diminum' : 'Terlewat', style: AppTextStyles.caption.copyWith(color: isTakenToday ? AppColors.success : AppColors.error, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildDayLog(String day, bool? status) {
    Color bgColor = AppColors.background;
    IconData? icon;
    Color iconColor = Colors.transparent;

    if (status == true) {
      bgColor = AppColors.success.withValues(alpha: 0.15);
      icon = Icons.check_circle_rounded;
      iconColor = AppColors.success;
    } else if (status == false) {
      bgColor = AppColors.error.withValues(alpha: 0.15);
      icon = Icons.cancel_rounded;
      iconColor = AppColors.error;
    }

    return Column(
      children: [
        Text(day, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: icon != null ? Icon(icon, size: 18, color: iconColor) : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

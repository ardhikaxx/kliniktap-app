import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/medication_adherence_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class MedicationAdherencePage extends GetView<MedicationAdherenceController> {
  const MedicationAdherencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 90),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Pantau persentase kepatuhan minum obat pasien kronis secara real-time.', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
              ),
              const SizedBox(height: 24),
              
              Expanded(
                child: Obx(() => ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
                  itemCount: controller.patients.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final p = controller.patients[index];
                    return _buildPatientCard(p);
                  },
                )),
              ),
            ],
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
                      Expanded(child: Text('Kepatuhan Minum Obat', textAlign: TextAlign.center, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary))),
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

  Widget _buildPatientCard(MedicationPatient patient) {
    Color progressColor;
    if (patient.adherencePercentage >= 80) progressColor = AppColors.success;
    else if (patient.adherencePercentage >= 50) progressColor = AppColors.warning;
    else progressColor = AppColors.error;

    return GestureDetector(
      onTap: () => Get.toNamed('/medication-adherence-detail', arguments: patient),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patient.name, style: AppTextStyles.h3),
                    const SizedBox(height: 4),
                    Text(patient.disease, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: progressColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Icon(Icons.medication_rounded, color: progressColor),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tingkat Kepatuhan', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
              Text('${patient.adherencePercentage}%', style: AppTextStyles.h2.copyWith(color: progressColor)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: patient.adherencePercentage / 100,
              backgroundColor: AppColors.background,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 14, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text('Terakhir minum: ${patient.lastTaken}', style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
            ],
          ),
        ],
      ),
      ),
    );
  }
}

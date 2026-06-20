import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/medical_record_detail_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/app_loading_indicator.dart';

class MedicalRecordDetailPage extends GetView<MedicalRecordDetailController> {
  const MedicalRecordDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Detail EMR'),
        elevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppLoadingIndicator();
        }

        final patient = controller.patient;
        return SingleChildScrollView(
          child: Column(
            children: [
              // Patient Header Info
              Container(
                color: AppColors.surface,
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    AppAvatar(imageUrl: patient.avatarUrl, size: 80),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(patient.patientName, style: AppTextStyles.h2),
                          const SizedBox(height: 4),
                          Text('ID: ${patient.id}', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildInfoChip(Icons.cake, '${controller.patientAge.value} thn'),
                              const SizedBox(width: 8),
                              _buildInfoChip(Icons.bloodtype, 'Gol ${controller.patientBloodType.value}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Vital Stats & Vitals
              Container(
                color: AppColors.surface,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildVitalStat('Tinggi', controller.patientHeight.value),
                    _buildVitalStat('Berat', controller.patientWeight.value),
                    _buildVitalStat('Gender', controller.patientGender.value),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Alergi
              Container(
                width: double.infinity,
                color: AppColors.surface,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Riwayat Alergi', style: AppTextStyles.h3),
                    const SizedBox(height: 12),
                    if (controller.allergies.isEmpty)
                      Text('Tidak ada riwayat alergi', style: AppTextStyles.body.copyWith(color: AppColors.textHint))
                    else
                      Wrap(
                        spacing: 8,
                        children: controller.allergies.map((allergy) {
                          return Chip(
                            label: Text(allergy, style: AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
                            backgroundColor: AppColors.error.withValues(alpha: 0.1),
                            side: BorderSide.none,
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Riwayat Medis / History
              Container(
                width: double.infinity,
                color: AppColors.surface,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Riwayat Pemeriksaan', style: AppTextStyles.h3),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.history.length,
                      itemBuilder: (context, index) {
                        final history = controller.history[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(history.date, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                                  Text(history.doctorName, style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(history.diagnosis, style: AppTextStyles.subtitle),
                              const SizedBox(height: 4),
                              Text(history.notes, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.primaryDark)),
        ],
      ),
    );
  }

  Widget _buildVitalStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.subtitle.copyWith(color: AppColors.textPrimary)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/medical_record_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/app_loading_indicator.dart';

class MedicalRecordPage extends GetView<MedicalRecordController> {
  const MedicalRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Rekam Medis (EMR)'),
        elevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.surface,
            child: TextField(
              onChanged: controller.search,
              decoration: InputDecoration(
                hintText: 'Cari nama pasien...',
                prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const AppLoadingIndicator();
              }
              
              if (controller.filteredRecords.isEmpty) {
                return Center(
                  child: Text('Tidak ada data pasien', style: AppTextStyles.body.copyWith(color: AppColors.textHint)),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.filteredRecords.length,
                itemBuilder: (context, index) {
                  final patient = controller.filteredRecords[index];
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColors.border),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Get.toNamed('/medical-record-detail', arguments: patient);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            AppAvatar(imageUrl: patient.avatarUrl, size: 56),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(patient.patientName, style: AppTextStyles.h3),
                                  const SizedBox(height: 4),
                                  Text(
                                    'ID: ${patient.id} • Kunjungan terakhir: Hari ini',
                                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: AppColors.primary),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/prescription_controller.dart';

class PrescriptionConfirmButton extends GetView<PrescriptionController> {
  const PrescriptionConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Obx(() {
        final isLastStep = controller.currentStep.value == 2;
        return ElevatedButton(
          onPressed: isLastStep ? controller.submitPrescription : controller.nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: isLastStep ? AppColors.accent : AppColors.primary,
            minimumSize: const Size.fromHeight(56),
            shadowColor: isLastStep ? AppColors.accent.withValues(alpha: 0.3) : AppColors.primary.withValues(alpha: 0.3),
            elevation: 4,
          ),
          child: Text(
            isLastStep ? 'Buat Resep & Kirim via WA' : 'Selanjutnya',
            style: AppTextStyles.button.copyWith(color: Colors.white),
          ),
        );
      }),
    );
  }
}

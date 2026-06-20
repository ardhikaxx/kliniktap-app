import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/prescription_controller.dart';

class DosageFrequencyChips extends GetView<PrescriptionController> {
  const DosageFrequencyChips({super.key});

  @override
  Widget build(BuildContext context) {
    final frequencies = ['1x sehari', '2x sehari', '3x sehari', '4x sehari'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Frekuensi', style: AppTextStyles.subtitle),
        const SizedBox(height: 8),
        Obx(
          () => Wrap(
            spacing: 8,
            children: frequencies.map((freq) {
              final isSelected = controller.selectedFreq.value == freq;
              return ChoiceChip(
                label: Text(
                  freq,
                  style: AppTextStyles.body.copyWith(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                selected: isSelected,
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.surface,
                side: BorderSide(color: isSelected ? Colors.transparent : AppColors.border),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onSelected: (val) {
                  if (val) controller.selectedFreq.value = freq;
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

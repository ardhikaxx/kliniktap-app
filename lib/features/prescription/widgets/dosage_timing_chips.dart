import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/prescription_controller.dart';

class DosageTimingChips extends GetView<PrescriptionController> {
  const DosageTimingChips({super.key});

  @override
  Widget build(BuildContext context) {
    final timings = ['Sebelum makan', 'Sesudah makan', 'Bersama makanan'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Waktu Konsumsi', style: AppTextStyles.subtitle),
        const SizedBox(height: 8),
        Obx(
          () => Wrap(
            spacing: 8,
            children: timings.map((time) {
              final isSelected = controller.selectedTiming.value == time;
              return ChoiceChip(
                label: Text(
                  time,
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
                  if (val) controller.selectedTiming.value = time;
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

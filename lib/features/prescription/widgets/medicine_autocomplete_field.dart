import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/prescription_controller.dart';

class MedicineAutocompleteField extends GetView<PrescriptionController> {
  const MedicineAutocompleteField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Cari nama obat...',
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
            prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            filled: true,
            fillColor: AppColors.surface,
          ),
          onChanged: controller.searchMedicine,
        ),
        Obx(() {
          if (controller.searchResults.isEmpty) return const SizedBox.shrink();
          return Container(
            margin: const EdgeInsets.only(top: 8),
            constraints: const BoxConstraints(maxHeight: 240),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: controller.searchResults.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.divider),
              itemBuilder: (context, index) {
                final med = controller.searchResults[index];
                return ListTile(
                  title: Text(med.name, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                  subtitle: Text(med.category, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    controller.selectMedicine(med);
                  },
                );
              },
            ),
          );
        }),
        Obx(() {
          final med = controller.selectedMedicine.value;
          if (med == null) return const SizedBox.shrink();
          return Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.medication, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(med.name, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
                      Text(med.commonDosage, style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.primary),
                  onPressed: controller.clearMedicine,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

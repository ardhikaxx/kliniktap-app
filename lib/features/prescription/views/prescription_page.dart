import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../controllers/prescription_controller.dart';
import '../widgets/medicine_autocomplete_field.dart';
import '../widgets/dosage_frequency_chips.dart';
import '../widgets/dosage_timing_chips.dart';
import '../widgets/prescription_confirm_button.dart';
import '../../../app/theme/app_text_styles.dart';

class PrescriptionPage extends GetView<PrescriptionController> {
  const PrescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main content
          Obx(() {
            return Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 90),
                Expanded(
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: controller.currentStep.value,
                onStepTapped: (step) => controller.currentStep.value = step,
                onStepContinue: controller.nextStep,
                onStepCancel: controller.prevStep,
                controlsBuilder: (context, details) => const SizedBox.shrink(),
                steps: [
                  Step(
                    title: const Text('Diagnosis'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Catatan & Diagnosis Medis:'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: controller.diagnosisController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Tulis diagnosis atau catatan pasien...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    isActive: controller.currentStep.value >= 0,
                    state: controller.currentStep.value > 0 ? StepState.complete : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Pilih Obat'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        MedicineAutocompleteField(),
                        SizedBox(height: 24),
                        DosageFrequencyChips(),
                        SizedBox(height: 24),
                        DosageTimingChips(),
                      ],
                    ),
                    isActive: controller.currentStep.value >= 1,
                    state: controller.currentStep.value > 1 ? StepState.complete : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Konfirmasi'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rangkuman Resep:', style: AppTextStyles.subtitle),
                        const SizedBox(height: 8),
                        if (controller.selectedMedicine.value != null)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(controller.selectedMedicine.value!.name),
                            subtitle: Text('${controller.selectedFreq.value} - ${controller.selectedTiming.value}'),
                          ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.send_to_mobile, color: Colors.green),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Resep PDF akan otomatis dikirimkan ke WhatsApp pasien (${controller.patient.patientName})',
                                  style: AppTextStyles.bodySmall.copyWith(color: Colors.green[800]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    isActive: controller.currentStep.value >= 2,
                  ),
                ],
              ),
            ),
            const PrescriptionConfirmButton(),
              ],
            );
          }),
          
          // Floating Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Buat Resep',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary),
                        ),
                      ),
                      const SizedBox(width: 56), // To balance the space of the left button
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
}

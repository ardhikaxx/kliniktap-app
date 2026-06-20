import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pain_scale_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class PainScalePage extends GetView<PainScaleController> {
  const PainScalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Seberapa sakit yang Anda rasakan?', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              Text('Geser pengukur di bawah ini', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: 64),
              
              Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 160, height: 160,
                decoration: BoxDecoration(
                  color: controller.painColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: controller.painColor, width: 4),
                  boxShadow: [
                    BoxShadow(color: controller.painColor.withValues(alpha: 0.3), blurRadius: 40, spreadRadius: 10),
                  ],
                ),
                child: Center(
                  child: Text(
                    controller.painEmoji,
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              )),
              
              const SizedBox(height: 48),
              
              Obx(() => Text(
                'Skala: ${controller.painLevel.value.toInt()}',
                style: AppTextStyles.h1.copyWith(fontSize: 48, color: controller.painColor),
              )),
              
              Obx(() => Text(
                controller.painDescription,
                style: AppTextStyles.h3.copyWith(color: controller.painColor),
              )),
              
              const SizedBox(height: 48),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(() => SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: controller.painColor,
                    inactiveTrackColor: AppColors.border,
                    thumbColor: controller.painColor,
                    trackHeight: 12,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16),
                    overlayColor: controller.painColor.withValues(alpha: 0.2),
                  ),
                  child: Slider(
                    value: controller.painLevel.value,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    onChanged: (val) => controller.painLevel.value = val,
                  ),
                )),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1 (Tidak Sakit)', style: AppTextStyles.caption.copyWith(color: Colors.green, fontWeight: FontWeight.bold)),
                    Text('10 (Sangat Sakit)', style: AppTextStyles.caption.copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
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
                      Expanded(child: Text('Pengukur Skala Nyeri', textAlign: TextAlign.center, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary))),
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
}

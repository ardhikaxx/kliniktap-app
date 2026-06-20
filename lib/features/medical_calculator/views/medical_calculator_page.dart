import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/medical_calculator_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

import 'subpages/bmi_calculator_page.dart';
import 'subpages/pediatric_dosage_page.dart';
import 'subpages/pregnancy_calculator_page.dart';

class MedicalCalculatorPage extends GetView<MedicalCalculatorController> {
  const MedicalCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 90,
              bottom: 40,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Peralatan Cerdas', style: AppTextStyles.h2),
                const SizedBox(height: 8),
                Text('Hitung dosis dan parameter medis secara instan dan akurat.', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 24),
                
                _buildCalculatorCard(
                  title: 'Kalkulator BMI',
                  description: 'Hitung Indeks Massa Tubuh (Body Mass Index) pasien dewasa.',
                  icon: Icons.monitor_weight_rounded,
                  color: const Color(0xFF4A90E2),
                  onTap: () => Get.to(() => const BmiCalculatorPage()),
                ),
                const SizedBox(height: 16),
                
                _buildCalculatorCard(
                  title: 'Dosis Obat Anak',
                  description: 'Hitung dosis pediatrik berdasarkan berat badan (mg/kgBB).',
                  icon: Icons.child_care_rounded,
                  color: const Color(0xFF50E3C2),
                  onTap: () => Get.to(() => const PediatricDosagePage()),
                ),
                const SizedBox(height: 16),
                
                _buildCalculatorCard(
                  title: 'Kalkulator HPL (ObGyn)',
                  description: 'Hitung Hari Perkiraan Lahir berdasarkan HPHT (Rumus Naegele).',
                  icon: Icons.pregnant_woman_rounded,
                  color: const Color(0xFFF5A623),
                  onTap: () => Get.to(() => const PregnancyCalculatorPage()),
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
                      Expanded(child: Text('Kalkulator Medis', textAlign: TextAlign.center, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary))),
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

  Widget _buildCalculatorCard({required String title, required String description, required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 8)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.h3),
                  const SizedBox(height: 4),
                  Text(description, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textHint),
            ),
          ],
        ),
      ),
    );
  }
}

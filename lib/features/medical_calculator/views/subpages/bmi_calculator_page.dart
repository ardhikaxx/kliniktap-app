import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';

class BmiCalculatorPage extends StatefulWidget {
  const BmiCalculatorPage({super.key});

  @override
  State<BmiCalculatorPage> createState() => _BmiCalculatorPageState();
}

class _BmiCalculatorPageState extends State<BmiCalculatorPage> {
  final TextEditingController _weightCtrl = TextEditingController();
  final TextEditingController _heightCtrl = TextEditingController();

  double? _bmiScore;
  String _category = '';
  Color _resultColor = AppColors.primary;

  void _calculateBMI() {
    final weight = double.tryParse(_weightCtrl.text);
    final heightCm = double.tryParse(_heightCtrl.text);

    if (weight != null && heightCm != null && heightCm > 0) {
      final heightM = heightCm / 100;
      final bmi = weight / pow(heightM, 2);
      
      setState(() {
        _bmiScore = bmi;
        if (bmi < 18.5) {
          _category = 'Kekurangan Berat Badan (Underweight)';
          _resultColor = const Color(0xFFF5A623); // Orange
        } else if (bmi >= 18.5 && bmi <= 24.9) {
          _category = 'Normal (Sehat)';
          _resultColor = AppColors.success;
        } else if (bmi >= 25.0 && bmi <= 29.9) {
          _category = 'Kelebihan Berat Badan (Overweight)';
          _resultColor = const Color(0xFFF5A623);
        } else {
          _category = 'Obesitas (Obese)';
          _resultColor = AppColors.error;
        }
      });
    } else {
      Get.snackbar('Input Tidak Valid', 'Masukkan berat dan tinggi badan dengan benar.', backgroundColor: AppColors.error.withValues(alpha: 0.1), colorText: AppColors.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 90, bottom: 40, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tinggi Badan (cm)', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      _buildTextField(_heightCtrl, 'Contoh: 170'),
                      const SizedBox(height: 16),
                      Text('Berat Badan (kg)', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      _buildTextField(_weightCtrl, 'Contoh: 65'),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _calculateBMI,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90E2),
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text('Hitung BMI', style: AppTextStyles.button.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                
                if (_bmiScore != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: _resultColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: _resultColor.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text('Skor BMI Anda', style: AppTextStyles.body.copyWith(color: _resultColor)),
                        const SizedBox(height: 8),
                        Text(_bmiScore!.toStringAsFixed(1), style: AppTextStyles.h1.copyWith(fontSize: 48, color: _resultColor)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _resultColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(_category, style: AppTextStyles.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
          _buildFloatingHeader('Kalkulator BMI'),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: AppTextStyles.body,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildFloatingHeader(String title) {
    return Positioned(
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
                Expanded(child: Text(title, textAlign: TextAlign.center, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary))),
                const SizedBox(width: 56),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

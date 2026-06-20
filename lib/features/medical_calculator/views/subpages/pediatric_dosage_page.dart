import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';

class PediatricDosagePage extends StatefulWidget {
  const PediatricDosagePage({super.key});

  @override
  State<PediatricDosagePage> createState() => _PediatricDosagePageState();
}

class _PediatricDosagePageState extends State<PediatricDosagePage> {
  final TextEditingController _weightCtrl = TextEditingController();
  final TextEditingController _dosePerKgCtrl = TextEditingController();
  final TextEditingController _frequencyCtrl = TextEditingController();

  double? _dailyDose;
  double? _singleDose;

  void _calculate() {
    final weight = double.tryParse(_weightCtrl.text);
    final dosePerKg = double.tryParse(_dosePerKgCtrl.text);
    final freq = double.tryParse(_frequencyCtrl.text);

    if (weight != null && dosePerKg != null && freq != null && freq > 0) {
      setState(() {
        _dailyDose = weight * dosePerKg;
        _singleDose = _dailyDose! / freq;
      });
    } else {
      Get.snackbar('Input Tidak Valid', 'Mohon isi semua field dengan angka yang benar.');
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
                      Text('Berat Badan Anak (kg)', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      _buildTextField(_weightCtrl, 'Contoh: 12.5'),
                      const SizedBox(height: 16),
                      Text('Dosis Obat (mg/kgBB/hari)', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      _buildTextField(_dosePerKgCtrl, 'Contoh: 15 (Utk Paracetamol)'),
                      const SizedBox(height: 16),
                      Text('Frekuensi Pemberian (Kali/hari)', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      _buildTextField(_frequencyCtrl, 'Contoh: 3'),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _calculate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF50E3C2),
                          foregroundColor: Colors.black87,
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text('Hitung Dosis', style: AppTextStyles.button),
                      ),
                    ],
                  ),
                ),
                
                if (_dailyDose != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF50E3C2).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFF50E3C2).withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text('Rekomendasi Dosis', style: AppTextStyles.h3.copyWith(color: const Color(0xFF009688))),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Total Per Hari', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                                const SizedBox(height: 8),
                                Text('${_dailyDose!.toStringAsFixed(1)} mg', style: AppTextStyles.h2.copyWith(color: const Color(0xFF009688))),
                              ],
                            ),
                            Container(width: 1, height: 40, color: const Color(0xFF50E3C2).withValues(alpha: 0.5)),
                            Column(
                              children: [
                                Text('Sekali Minum', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                                const SizedBox(height: 8),
                                Text('${_singleDose!.toStringAsFixed(1)} mg', style: AppTextStyles.h2.copyWith(color: const Color(0xFF009688))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          _buildFloatingHeader('Dosis Obat Anak'),
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

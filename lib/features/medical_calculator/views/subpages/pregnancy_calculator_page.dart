import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';

class PregnancyCalculatorPage extends StatefulWidget {
  const PregnancyCalculatorPage({super.key});

  @override
  State<PregnancyCalculatorPage> createState() => _PregnancyCalculatorPageState();
}

class _PregnancyCalculatorPageState extends State<PregnancyCalculatorPage> {
  DateTime? _hphtDate;
  DateTime? _hplDate;
  int? _gestationalAgeWeeks;
  int? _gestationalAgeDays;

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 300)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFFF5A623)),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        _hphtDate = date;
      });
      _calculate();
    }
  }

  void _calculate() {
    if (_hphtDate == null) return;

    // Rumus Naegele: HPHT + 7 hari - 3 bulan + 1 tahun
    // Di Dart lebih aman menggunakan penambahan 280 hari (40 minggu)
    final hpl = _hphtDate!.add(const Duration(days: 280));
    
    final now = DateTime.now();
    final difference = now.difference(_hphtDate!);
    final weeks = difference.inDays ~/ 7;
    final days = difference.inDays % 7;

    setState(() {
      _hplDate = hpl;
      _gestationalAgeWeeks = weeks;
      _gestationalAgeDays = days;
    });
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
                      Text('Hari Pertama Haid Terakhir (HPHT)', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _pickDate,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _hphtDate != null ? DateFormat('dd MMMM yyyy').format(_hphtDate!) : 'Pilih Tanggal',
                                style: AppTextStyles.body.copyWith(color: _hphtDate != null ? AppColors.textPrimary : AppColors.textHint),
                              ),
                              const Icon(Icons.calendar_month_rounded, color: Color(0xFFF5A623)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Rumus yang digunakan adalah Rumus Naegele (+7 hari, -3 bulan, +1 tahun).', style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
                    ],
                  ),
                ),
                
                if (_hplDate != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF5A623), Color(0xFFF76B1C)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFFF5A623).withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.child_friendly_rounded, color: Colors.white, size: 48),
                        const SizedBox(height: 16),
                        Text('Hari Perkiraan Lahir (HPL)', style: AppTextStyles.body.copyWith(color: Colors.white.withValues(alpha: 0.9))),
                        const SizedBox(height: 8),
                        Text(DateFormat('dd MMMM yyyy').format(_hplDate!), style: AppTextStyles.h1.copyWith(color: Colors.white, fontSize: 28)),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.hourglass_bottom_rounded, color: Colors.white, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                'Usia Kehamilan: $_gestationalAgeWeeks Minggu, $_gestationalAgeDays Hari',
                                style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          _buildFloatingHeader('Kalkulator Kehamilan'),
        ],
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

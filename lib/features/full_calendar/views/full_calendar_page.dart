import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/full_calendar_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class FullCalendarPage extends GetView<FullCalendarController> {
  const FullCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    final now = DateTime.now();
    // Dummy calendar: 30 days
    final daysInMonth = 30;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 90,
              bottom: 40,
            ),
            child: Column(
              children: [
                // Calendar Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Juni 2026', style: AppTextStyles.h2),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.chevron_left_rounded, size: 20),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.chevron_right_rounded, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Days Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: days.map((day) => SizedBox(
                      width: 40,
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.caption.copyWith(color: AppColors.textHint, fontWeight: FontWeight.w700),
                      ),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Calendar Grid
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: daysInMonth + 2, // offset for start day
                    itemBuilder: (context, index) {
                      if (index < 2) return const SizedBox(); // offset
                      
                      final dayNum = index - 1;
                      final isToday = dayNum == now.day;
                      final hasAppointment = [5, 12, 14, 20, 22].contains(dayNum);
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: isToday ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: isToday ? null : Border.all(color: AppColors.border.withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$dayNum',
                              style: AppTextStyles.body.copyWith(
                                color: isToday ? Colors.white : AppColors.textPrimary,
                                fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                            if (hasAppointment) ...[
                              const SizedBox(height: 4),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isToday ? Colors.white : AppColors.secondary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ]
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 24),
                // Today's schedule
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Jadwal Hari Ini', style: AppTextStyles.h3),
                  ),
                ),
                const SizedBox(height: 16),
                
                // List of schedules
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.people_alt_rounded, color: AppColors.primary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('10 Pasien Terjadwal', style: AppTextStyles.subtitle),
                            Text('Sesi Pagi (08:00 - 12:00)', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textHint),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Floating Pill Header
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
                      BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 8)),
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
                          decoration: const BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18),
                        ),
                      ),
                      Expanded(
                        child: Text('Kalender Janji Temu', textAlign: TextAlign.center, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary)),
                      ),
                      const SizedBox(width: 56), // Balance
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

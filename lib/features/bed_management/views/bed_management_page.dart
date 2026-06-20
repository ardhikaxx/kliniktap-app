import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bed_management_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class BedManagementPage extends GetView<BedManagementController> {
  const BedManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    // We need to put controller lazyPut in MainNavBinding or init here if not using routing
    Get.put(BedManagementController());
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 90),
              
              // Legend
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildLegendItem(AppColors.primary, 'Terisi'),
                    const SizedBox(width: 12),
                    _buildLegendItem(AppColors.success, 'Kosong'),
                    const SizedBox(width: 12),
                    _buildLegendItem(AppColors.warning, 'Pembersihan'),
                    const SizedBox(width: 12),
                    _buildLegendItem(AppColors.textHint, 'Perbaikan'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Bed Grid
              Expanded(
                child: Obx(() {
                  return GridView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 120),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: controller.beds.length,
                    itemBuilder: (context, index) {
                      final bed = controller.beds[index];
                      return _buildBedCard(bed);
                    },
                  );
                }),
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
                      const SizedBox(width: 24),
                      Expanded(
                        child: Text(
                          'Rawat Inap & Bangsal', 
                          style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        width: 48, height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.bed_rounded, color: AppColors.primary),
                      ),
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

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12, height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildBedCard(BedItem bed) {
    Color statusColor;
    IconData statusIcon;
    
    switch (bed.status) {
      case BedStatus.occupied:
        statusColor = AppColors.primary;
        statusIcon = Icons.monitor_heart_rounded;
        break;
      case BedStatus.available:
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle_rounded;
        break;
      case BedStatus.cleaning:
        statusColor = AppColors.warning;
        statusIcon = Icons.cleaning_services_rounded;
        break;
      case BedStatus.maintenance:
        statusColor = AppColors.textHint;
        statusIcon = Icons.build_rounded;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header color strip
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(bed.name, style: AppTextStyles.h3),
                    Icon(statusIcon, color: statusColor, size: 20),
                  ],
                ),
                const SizedBox(height: 4),
                Text(bed.room, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1),
                ),
                
                if (bed.status == BedStatus.occupied) ...[
                  Text('Pasien:', style: AppTextStyles.caption.copyWith(color: AppColors.textHint, fontSize: 10)),
                  Text(bed.patientName ?? '', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('Hari ke-${bed.admittedDays}', style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                  ),
                ] else if (bed.status == BedStatus.available) ...[
                  const SizedBox(height: 8),
                  Center(
                    child: Text('Kosong', style: AppTextStyles.body.copyWith(color: AppColors.success, fontWeight: FontWeight.w600)),
                  ),
                ] else if (bed.status == BedStatus.cleaning) ...[
                  const SizedBox(height: 8),
                  Center(
                    child: Text('Pembersihan', style: AppTextStyles.body.copyWith(color: AppColors.warning, fontWeight: FontWeight.w600)),
                  ),
                ] else ...[
                  const SizedBox(height: 8),
                  Center(
                    child: Text('Perbaikan', style: AppTextStyles.body.copyWith(color: AppColors.textHint, fontWeight: FontWeight.w600)),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

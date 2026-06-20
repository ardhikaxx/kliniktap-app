import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/triage_board_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class TriageBoardPage extends GetView<TriageBoardController> {
  const TriageBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 90),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Tahan dan geser (drag & drop) kartu pasien ke kolom prioritas yang sesuai.', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
              ),
              const SizedBox(height: 16),
              
              // Kanban Board
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildColumn(TriageLevel.red, 'Resusitasi & Gawat', AppColors.error),
                      const SizedBox(width: 16),
                      _buildColumn(TriageLevel.yellow, 'Darurat (Urgent)', AppColors.warning),
                      const SizedBox(width: 16),
                      _buildColumn(TriageLevel.green, 'Tidak Gawat (Non-Urgent)', AppColors.success),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
                      Expanded(child: Text('Papan Triage IGD', textAlign: TextAlign.center, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary))),
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

  Widget _buildColumn(TriageLevel level, String title, Color color) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          // Column Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(title, style: AppTextStyles.h3.copyWith(color: color, fontSize: 16))),
                Obx(() {
                  final list = _getList(level);
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
                    child: Text('${list.length}', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  );
                }),
              ],
            ),
          ),
          
          // Drop Target List
          Expanded(
            child: DragTarget<TriagePatient>(
              onWillAcceptWithDetails: (details) => true,
              onAcceptWithDetails: (details) {
                controller.updatePatientLevel(details.data.id, level);
              },
              builder: (context, candidateData, rejectedData) {
                return Obx(() {
                  final list = _getList(level);
                  return ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final patient = list[index];
                      return Draggable<TriagePatient>(
                        data: patient,
                        feedback: Material(
                          color: Colors.transparent,
                          child: Opacity(
                            opacity: 0.8,
                            child: SizedBox(width: 256, child: _buildPatientCard(patient, color)),
                          ),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: _buildPatientCard(patient, color),
                        ),
                        child: _buildPatientCard(patient, color),
                      );
                    },
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  List<TriagePatient> _getList(TriageLevel level) {
    switch (level) {
      case TriageLevel.red:
        return controller.redPatients;
      case TriageLevel.yellow:
        return controller.yellowPatients;
      case TriageLevel.green:
        return controller.greenPatients;
    }
  }

  Widget _buildPatientCard(TriagePatient patient, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 4))],
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(patient.id, style: AppTextStyles.caption.copyWith(color: AppColors.textHint, fontWeight: FontWeight.bold)),
              Icon(Icons.drag_indicator_rounded, color: AppColors.textHint, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(patient.name, style: AppTextStyles.h3.copyWith(fontSize: 14)),
          const SizedBox(height: 4),
          Text(patient.complaint, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

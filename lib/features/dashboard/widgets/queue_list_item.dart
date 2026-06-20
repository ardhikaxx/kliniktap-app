import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../data/models/patient_queue_model.dart';
import '../../../shared/widgets/app_avatar.dart';
import 'priority_badge.dart';

class QueueListItem extends StatelessWidget {
  final PatientQueueModel patient;

  const QueueListItem({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          AppAvatar(imageUrl: patient.avatarUrl, size: 48),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patient.patientName, style: AppTextStyles.subtitle),
                const SizedBox(height: 4),
                Text(
                  'Janji Temu: ${patient.appointmentTime}',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PriorityBadge(priority: patient.priority),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.prescription, arguments: patient);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.assignment_add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

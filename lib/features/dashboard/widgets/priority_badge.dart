import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class PriorityBadge extends StatelessWidget {
  final String priority;

  const PriorityBadge({super.key, required this.priority});

  Color _getPriorityColor() {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppColors.priorityHigh;
      case 'medium':
        return AppColors.priorityMedium;
      case 'low':
      default:
        return AppColors.priorityLow;
    }
  }

  String _getPriorityLabel() {
    switch (priority.toLowerCase()) {
      case 'high':
        return 'DARURAT';
      case 'medium':
        return 'URGENT';
      case 'low':
      default:
        return 'RUTIN';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getPriorityColor();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          _getPriorityLabel(),
          style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

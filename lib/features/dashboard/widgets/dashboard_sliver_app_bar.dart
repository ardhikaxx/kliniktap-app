import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../data/models/doctor_model.dart';
import '../../../shared/widgets/app_avatar.dart';

class DashboardSliverAppBar extends StatelessWidget {
  final DoctorModel doctor;

  const DashboardSliverAppBar({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: LayoutBuilder(
          builder: (context, constraints) {
            bool isCollapsed = constraints.biggest.height <= kToolbarHeight + 20;
            return Row(
              children: [
                if (isCollapsed)
                  AppAvatar(imageUrl: doctor.avatarUrl, size: 36)
                else
                  const SizedBox.shrink(),
                if (isCollapsed) const SizedBox(width: 12),
                Text(
                  isCollapsed ? 'Dasbor' : 'Selamat Pagi,\ndr. ${doctor.name}',
                  style: isCollapsed 
                      ? AppTextStyles.h3.copyWith(color: Colors.white)
                      : AppTextStyles.h3.copyWith(color: Colors.white, height: 1.2),
                ),
              ],
            );
          },
        ),
        background: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryDark, AppColors.primaryLight],
                ),
              ),
            ),
            // Decorative circle
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 60,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: AppAvatar(imageUrl: doctor.avatarUrl, size: 64),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_none, color: Colors.white, size: 28),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

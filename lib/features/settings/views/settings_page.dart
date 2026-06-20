import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

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
            ),
            child: Column(
              children: [
                _buildSettingsGroup(
                  'Preferensi Aplikasi',
                  [
                    _buildSettingsItem(Icons.dark_mode_rounded, 'Mode Gelap (Dark Mode)', isSwitch: true, value: false),
                    _buildSettingsItem(Icons.language_rounded, 'Bahasa', valueText: 'Indonesia'),
                    _buildSettingsItem(Icons.notifications_active_rounded, 'Notifikasi Push', isSwitch: true, value: true),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSettingsGroup(
                  'Akun & Keamanan',
                  [
                    _buildSettingsItem(Icons.lock_rounded, 'Ubah Kata Sandi'),
                    _buildSettingsItem(Icons.security_rounded, 'Autentikasi Dua Langkah (2FA)'),
                    _buildSettingsItem(Icons.fingerprint_rounded, 'Gunakan Biometrik', isSwitch: true, value: true),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSettingsGroup(
                  'Bantuan & Informasi',
                  [
                    _buildSettingsItem(Icons.help_center_rounded, 'Pusat Bantuan'),
                    _buildSettingsItem(Icons.privacy_tip_rounded, 'Kebijakan Privasi'),
                    _buildSettingsItem(Icons.info_rounded, 'Tentang Aplikasi', valueText: 'v1.0.0'),
                  ],
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
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
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
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Pengaturan',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary),
                        ),
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

  Widget _buildSettingsGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Text(title, style: AppTextStyles.h3),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: items.map((item) {
              final isLast = items.last == item;
              return Column(
                children: [
                  item,
                  if (!isLast) const Divider(height: 1, color: AppColors.border),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, {bool isSwitch = false, bool value = false, String? valueText}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title, style: AppTextStyles.subtitle.copyWith(fontSize: 15)),
          ),
          if (isSwitch)
            Switch(
              value: value,
              onChanged: (v) {},
              activeColor: AppColors.primary,
            )
          else if (valueText != null)
            Row(
              children: [
                Text(valueText, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textHint),
              ],
            )
          else
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textHint),
        ],
      ),
    );
  }
}

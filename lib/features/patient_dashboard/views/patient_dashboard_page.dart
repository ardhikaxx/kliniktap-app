import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import 'notifications_page.dart';
import 'qr_scanner_page.dart';
import 'doctor_profile_page.dart';
import 'article_detail_page.dart';
import 'virtual_assistant_page.dart';
import '../../main_nav/controllers/main_nav_controller.dart';

class PatientDashboardPage extends StatelessWidget {
  const PatientDashboardPage({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat Pagi';
    if (hour < 15) return 'Selamat Siang';
    if (hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100), // Angkat tombol agar tidak tertutup nav bottom
        child: FloatingActionButton(
          onPressed: () => Get.to(() => const VirtualAssistantPage()),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.support_agent_rounded, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          // Dynamic Background Element
          Positioned(
            top: -150,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: Colors.white,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
            },
            child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 110,
              bottom: 120, // Extra space for nav bar
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Digital Health Card (Premium Look)
                _buildDigitalHealthCard(),
                
                const SizedBox(height: 36),
                
                // Section Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Layanan Utama', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                    Icon(Icons.more_horiz_rounded, color: AppColors.textHint),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Premium Grid Services
                LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = (constraints.maxWidth - (3 * 12)) / 4;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 20,
                      children: [
                        SizedBox(width: itemWidth, child: _buildIconService(Icons.domain_verification_rounded, 'Reservasi\nPoli', const Color(0xFF3B82F6), () {
                          Get.find<MainNavController>().changeTab(1);
                        })),
                        SizedBox(width: itemWidth, child: _buildIconService(Icons.monitor_heart_rounded, 'Rekam\nMedis', const Color(0xFF10B981), () {
                          Get.find<MainNavController>().changeTab(2);
                        })),
                        SizedBox(width: itemWidth, child: _buildIconService(Icons.video_camera_front_rounded, 'Tele\nKonsul', const Color(0xFFF59E0B), () => Get.toNamed('/teleconsultation'))),
                        SizedBox(width: itemWidth, child: _buildIconService(Icons.receipt_long_rounded, 'Tagihan\nRS', const Color(0xFF8B5CF6), () => Get.toNamed('/hospital-billing'))),
                        SizedBox(width: itemWidth, child: _buildIconService(Icons.medical_services_rounded, 'Farmasi', const Color(0xFFEC4899), () => Get.toNamed('/pharmacy'))),
                        SizedBox(width: itemWidth, child: _buildIconService(Icons.science_rounded, 'Hasil\nLab', const Color(0xFF14B8A6), () => Get.toNamed('/lab-results'))),
                        SizedBox(width: itemWidth, child: _buildIconService(Icons.emergency_rounded, 'IGD\nDarurat', const Color(0xFFEF4444), () => Get.toNamed('/emergency'))),
                        SizedBox(width: itemWidth, child: _buildIconService(Icons.grid_view_rounded, 'Semua\nMenu', AppColors.textSecondary, () => Get.toNamed('/all-services'))),
                      ],
                    );
                  }
                ),
                
                const SizedBox(height: 24),
                _buildPromoCarousel(),
                
                const SizedBox(height: 32),
                
                // Active Queue (Boarding Pass Style)
                Text('Antrean Aktif Saat Ini', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                const SizedBox(height: 16),
                _buildActiveQueueTicket(),

                const SizedBox(height: 32),
                Text('Artikel Kesehatan Terkini', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                const SizedBox(height: 16),
                _buildHealthArticles(),
                
                const SizedBox(height: 32),
                Text('Dokter Tersedia Hari Ini', style: AppTextStyles.h2.copyWith(fontSize: 20)),
                const SizedBox(height: 16),
                _buildAvailableDoctors(),
              ],
            ),
          ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 8))],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primarySurface,
                          child: Text('YA', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${_getGreeting()},', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontSize: 10)),
                            Text('Yanuar Ardhika R.U', style: AppTextStyles.subtitle.copyWith(color: AppColors.textPrimary)),
                          ],
                        ),
                      ),
                      Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => Get.to(() => const NotificationsPage()),
                          icon: const Icon(Icons.notifications_outlined, color: AppColors.textSecondary, size: 16),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.bottomSheet(
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                                ),
                                child: SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
                                      const SizedBox(height: 24),
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), shape: BoxShape.circle),
                                        child: const Icon(Icons.logout_rounded, color: AppColors.error, size: 40),
                                      ),
                                      const SizedBox(height: 16),
                                      Text('Keluar dari Akun?', style: AppTextStyles.h2),
                                      const SizedBox(height: 8),
                                      Text('Anda harus login kembali untuk mengakses layanan KlinikTap.', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
                                      const SizedBox(height: 32),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () => Get.back(),
                                              style: OutlinedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(vertical: 16),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                                side: BorderSide(color: AppColors.border),
                                              ),
                                              child: Text('Batal', style: AppTextStyles.button.copyWith(color: AppColors.textPrimary)),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                                Get.offAllNamed('/login');
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.error,
                                                padding: const EdgeInsets.symmetric(vertical: 16),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                              ),
                                              child: Text('Keluar', style: AppTextStyles.button.copyWith(color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.logout_rounded, color: AppColors.textSecondary, size: 16),
                        ),
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

  Widget _buildDigitalHealthCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF0A585B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Abstract Card Design Elements
          Positioned(
            right: -30,
            top: -20,
            child: Icon(Icons.medical_services_rounded, size: 120, color: Colors.white.withValues(alpha: 0.05)),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified_rounded, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text('BPJS AKTIF', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Icon(Icons.contactless_rounded, color: Colors.white, size: 24),
                ],
              ),
              const SizedBox(height: 32),
              Text('Nomor Rekam Medis (RM)', style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.8))),
              const SizedBox(height: 4),
              Text('RM-8820-192', style: AppTextStyles.h1.copyWith(color: Colors.white, letterSpacing: 2, fontSize: 24)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pasien', style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.8))),
                      Text('YANUAR ARDHIKA R.U', style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/SatuSehat_Logo.png/800px-SatuSehat_Logo.png',
                    height: 24,
                    color: Colors.white,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.health_and_safety_rounded, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconService(IconData icon, String title, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveQueueTicket() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.access_time_filled_rounded, color: AppColors.warning),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Poli Penyakit Dalam', style: AppTextStyles.h3),
                          Text('A-12', style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('dr. Andi Pratama, Sp.PD', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.people_alt_rounded, size: 16, color: AppColors.textHint),
                          const SizedBox(width: 6),
                          Text('2 antrean di depan Anda', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Dashed Divider
          Row(
            children: [
              SizedBox(
                height: 20,
                width: 10,
                child: DecoratedBox(decoration: BoxDecoration(color: AppColors.background, borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)))),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(
                          (constraints.constrainWidth() / 8).floor(),
                          (index) => SizedBox(width: 4, height: 1.5, child: DecoratedBox(decoration: BoxDecoration(color: AppColors.border))),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                width: 10,
                child: DecoratedBox(decoration: BoxDecoration(color: AppColors.background, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)))),
              ),
            ],
          ),
          
          // Bottom Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Estimasi Panggil', style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
                    Text('10:45 WIB', style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => Get.to(() => const QrScannerPage()),
                  icon: const Icon(Icons.qr_code_scanner_rounded, size: 20),
                  label: const Text('Scan KiosK'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCarousel() {
    final List<Map<String, dynamic>> promos = [
      {
        'title': 'Medical Check Up\nKeluarga',
        'subtitle': 'Diskon 20% khusus member',
        'color1': const Color(0xFF3B82F6),
        'color2': const Color(0xFF2563EB),
        'icon': Icons.family_restroom_rounded,
      },
      {
        'title': 'Layanan Homecare\n24 Jam',
        'subtitle': 'Dokter ke rumah Anda',
        'color1': const Color(0xFF10B981),
        'color2': const Color(0xFF059669),
        'icon': Icons.home_repair_service_rounded,
      },
    ];

    return SizedBox(
      height: 160,
      child: PageView.builder(
        itemCount: promos.length,
        controller: PageController(viewportFraction: 1.0),
        itemBuilder: (context, index) {
          final promo = promos[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [promo['color1'] as Color, promo['color2'] as Color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: (promo['color1'] as Color).withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8)),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                        child: Text('PROMO', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 12),
                      Text(promo['title'] as String, style: AppTextStyles.h2.copyWith(color: Colors.white, fontSize: 18)),
                      const SizedBox(height: 4),
                      Text(promo['subtitle'] as String, style: AppTextStyles.body.copyWith(color: Colors.white.withValues(alpha: 0.9))),
                    ],
                  ),
                ),
                Icon(promo['icon'] as IconData, size: 80, color: Colors.white.withValues(alpha: 0.2)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHealthArticles() {
    final List<Map<String, dynamic>> articles = [
      {'title': 'Pentingnya Cek Gula Darah Rutin', 'category': 'Edukasi', 'color': const Color(0xFF3B82F6), 'icon': Icons.bloodtype_rounded},
      {'title': 'Promo Vaksin Flu Akhir Tahun', 'category': 'Promo', 'color': const Color(0xFFF59E0B), 'icon': Icons.vaccines_rounded},
      {'title': 'Mengenal Gejala Awal Demam Berdarah', 'category': 'Kesehatan', 'color': const Color(0xFFEF4444), 'icon': Icons.coronavirus_rounded},
    ];

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return GestureDetector(
            onTap: () => Get.to(() => ArticleDetailPage(article: article)),
            child: Container(
              width: 240,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: (article['color'] as Color).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(article['category'] as String, style: AppTextStyles.caption.copyWith(color: article['color'] as Color, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(article['title'] as String, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 12),
                    Icon(article['icon'] as IconData, color: article['color'] as Color, size: 32),
                  ],
                ),
              ],
            ),
          ));
        },
      ),
    );
  }

  Widget _buildAvailableDoctors() {
    final List<Map<String, dynamic>> doctors = [
      {'name': 'dr. Andi Pratama, Sp.PD', 'spesialis': 'Penyakit Dalam', 'rating': '4.9'},
      {'name': 'dr. Budi Santoso, Sp.A', 'spesialis': 'Anak', 'rating': '4.8'},
      {'name': 'dr. Citra Lestari, Sp.OG', 'spesialis': 'Kandungan', 'rating': '5.0'},
    ];

    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return GestureDetector(
            onTap: () => Get.to(() => DoctorProfilePage(doctor: doctor)),
            child: Container(
              width: 160,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.primarySurface,
                      child: Icon(Icons.person_rounded, size: 36, color: AppColors.primary),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.verified_rounded, color: AppColors.success, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(doctor['name'] as String, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(doctor['spesialis'] as String, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star_rounded, color: AppColors.warning, size: 14),
                    const SizedBox(width: 4),
                    Text(doctor['rating'] as String, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}

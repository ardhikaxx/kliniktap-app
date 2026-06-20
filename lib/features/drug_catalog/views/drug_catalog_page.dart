import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/drug_catalog_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class DrugCatalogPage extends GetView<DrugCatalogController> {
  const DrugCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final drugs = [
      {'name': 'Paracetamol 500mg', 'category': 'Obat Bebas', 'stock': 120, 'price': 'Rp 5.000'},
      {'name': 'Amoxicillin 250mg', 'category': 'Antibiotik', 'stock': 45, 'price': 'Rp 12.000'},
      {'name': 'Ibuprofen 400mg', 'category': 'Pereda Nyeri', 'stock': 85, 'price': 'Rp 8.500'},
      {'name': 'Omeprazole 20mg', 'category': 'Obat Lambung', 'stock': 30, 'price': 'Rp 15.000'},
      {'name': 'Vitamin C 1000mg', 'category': 'Suplemen', 'stock': 200, 'price': 'Rp 25.000'},
      {'name': 'Cetirizine 10mg', 'category': 'Antialergi', 'stock': 60, 'price': 'Rp 10.000'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          ListView.separated(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 90,
              bottom: 40,
              left: 16,
              right: 16,
            ),
            itemCount: drugs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final drug = drugs[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.medication_rounded, color: AppColors.primary, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(drug['name'] as String, style: AppTextStyles.subtitle),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              drug['category'] as String,
                              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          drug['price'] as String,
                          style: AppTextStyles.h3.copyWith(fontSize: 15, color: AppColors.primaryDark),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Stok: ${drug['stock']}',
                          style: AppTextStyles.caption.copyWith(
                            color: (drug['stock'] as int) < 50 ? AppColors.warning : AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
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
                          'Katalog Obat',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.search_rounded, color: AppColors.primary, size: 20),
                        ),
                      ),
                      const SizedBox(width: 8),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/icd10_dictionary_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class Icd10DictionaryPage extends GetView<Icd10DictionaryController> {
  const Icd10DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Content
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 90),
              
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: TextField(
                    controller: controller.searchCtrl,
                    style: AppTextStyles.body,
                    decoration: InputDecoration(
                      hintText: 'Cari nama penyakit atau kode ICD-10...',
                      hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // List
              Expanded(
                child: Obx(() {
                  if (controller.filteredList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search_off_rounded, size: 64, color: AppColors.border),
                          const SizedBox(height: 16),
                          Text('Kode tidak ditemukan', style: AppTextStyles.subtitle.copyWith(color: AppColors.textSecondary)),
                        ],
                      ),
                    );
                  }
                  
                  return ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
                    itemCount: controller.filteredList.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = controller.filteredList[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                item.code,
                                style: AppTextStyles.h2.copyWith(color: AppColors.primary),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.description, style: AppTextStyles.subtitle),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.background,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.border),
                                    ),
                                    child: Text(
                                      item.category,
                                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.content_copy_rounded, color: AppColors.textHint, size: 20),
                          ],
                        ),
                      );
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
                      Expanded(child: Text('Kamus ICD-10', textAlign: TextAlign.center, style: AppTextStyles.h2.copyWith(fontSize: 18, color: AppColors.textPrimary))),
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
}

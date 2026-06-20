import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PainScaleController extends GetxController {
  final RxDouble painLevel = 1.0.obs;

  String get painDescription {
    if (painLevel.value < 3) return 'Ringan / Sedikit Sakit';
    if (painLevel.value < 6) return 'Sedang / Mengganggu Aktivitas';
    if (painLevel.value < 8) return 'Berat / Sangat Menyiksa';
    return 'Sangat Berat / Tidak Tertahankan';
  }

  Color get painColor {
    if (painLevel.value < 3) return Colors.green;
    if (painLevel.value < 6) return Colors.orange;
    if (painLevel.value < 8) return Colors.deepOrange;
    return Colors.red;
  }

  String get painEmoji {
    if (painLevel.value < 2) return '😄';
    if (painLevel.value < 4) return '🙂';
    if (painLevel.value < 6) return '😐';
    if (painLevel.value < 8) return '😟';
    if (painLevel.value < 10) return '😫';
    return '😭';
  }
}

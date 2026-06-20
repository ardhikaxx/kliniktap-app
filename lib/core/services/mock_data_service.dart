import 'dart:convert';
import 'package:flutter/services.dart';

class MockDataService {
  Future<dynamic> loadJson(String path) async {
    try {
      final String jsonString = await rootBundle.loadString(path);
      return jsonDecode(jsonString);
    } catch (e) {
      throw Exception('Failed to load JSON from $path: $e');
    }
  }
}

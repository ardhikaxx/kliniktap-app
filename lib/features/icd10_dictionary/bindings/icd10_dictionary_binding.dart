import 'package:get/get.dart';
import '../controllers/icd10_dictionary_controller.dart';

class Icd10DictionaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Icd10DictionaryController());
  }
}

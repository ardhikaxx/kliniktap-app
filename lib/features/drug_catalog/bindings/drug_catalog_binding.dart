import 'package:get/get.dart';
import '../controllers/drug_catalog_controller.dart';

class DrugCatalogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DrugCatalogController());
  }
}

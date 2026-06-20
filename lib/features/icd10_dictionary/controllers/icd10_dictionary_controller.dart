import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Icd10Item {
  final String code;
  final String description;
  final String category;

  Icd10Item({required this.code, required this.description, required this.category});
}

class Icd10DictionaryController extends GetxController {
  final TextEditingController searchCtrl = TextEditingController();
  
  final List<Icd10Item> _fullDatabase = [
    // Infeksi
    Icd10Item(code: 'A01.0', description: 'Typhoid fever', category: 'Infeksi & Parasit'),
    Icd10Item(code: 'A09.9', description: 'Gastroenteritis and colitis of unspecified origin', category: 'Infeksi & Parasit'),
    Icd10Item(code: 'A15.0', description: 'Tuberculosis of lung', category: 'Infeksi & Parasit'),
    Icd10Item(code: 'A90', description: 'Dengue fever [classical dengue]', category: 'Infeksi & Parasit'),
    Icd10Item(code: 'A91', description: 'Dengue haemorrhagic fever', category: 'Infeksi & Parasit'),
    Icd10Item(code: 'B01.9', description: 'Varicella (chickenpox) without complication', category: 'Infeksi & Parasit'),
    Icd10Item(code: 'B05.9', description: 'Measles without complication', category: 'Infeksi & Parasit'),
    
    // Metabolik & Endokrin
    Icd10Item(code: 'E11.9', description: 'Type 2 diabetes mellitus without complications', category: 'Metabolik & Endokrin'),
    Icd10Item(code: 'E78.5', description: 'Hyperlipidaemia, unspecified', category: 'Metabolik & Endokrin'),
    Icd10Item(code: 'E05.9', description: 'Thyrotoxicosis, unspecified', category: 'Metabolik & Endokrin'),
    
    // Kardiovaskular
    Icd10Item(code: 'I10', description: 'Essential (primary) hypertension', category: 'Kardiovaskular'),
    Icd10Item(code: 'I20.9', description: 'Angina pectoris, unspecified', category: 'Kardiovaskular'),
    Icd10Item(code: 'I21.9', description: 'Acute myocardial infarction, unspecified', category: 'Kardiovaskular'),
    Icd10Item(code: 'I50.9', description: 'Heart failure, unspecified', category: 'Kardiovaskular'),
    
    // Pernapasan
    Icd10Item(code: 'J00', description: 'Acute nasopharyngitis [common cold]', category: 'Pernapasan'),
    Icd10Item(code: 'J01.9', description: 'Acute sinusitis, unspecified', category: 'Pernapasan'),
    Icd10Item(code: 'J02.9', description: 'Acute pharyngitis, unspecified', category: 'Pernapasan'),
    Icd10Item(code: 'J03.9', description: 'Acute tonsillitis, unspecified', category: 'Pernapasan'),
    Icd10Item(code: 'J06.9', description: 'Acute upper respiratory infection, unspecified', category: 'Pernapasan'),
    Icd10Item(code: 'J18.9', description: 'Pneumonia, unspecified organism', category: 'Pernapasan'),
    Icd10Item(code: 'J45.9', description: 'Asthma, unspecified', category: 'Pernapasan'),
    
    // Pencernaan
    Icd10Item(code: 'K04.0', description: 'Pulpitis (Gigi)', category: 'Pencernaan'),
    Icd10Item(code: 'K21.9', description: 'Gastro-oesophageal reflux disease (GERD)', category: 'Pencernaan'),
    Icd10Item(code: 'K29.7', description: 'Gastritis, unspecified', category: 'Pencernaan'),
    Icd10Item(code: 'K35.8', description: 'Acute appendicitis, other and unspecified', category: 'Pencernaan'),
    
    // Kulit
    Icd10Item(code: 'L20.9', description: 'Atopic dermatitis, unspecified', category: 'Kulit'),
    Icd10Item(code: 'L23.9', description: 'Allergic contact dermatitis, unspecified cause', category: 'Kulit'),
    Icd10Item(code: 'L50.9', description: 'Urticaria, unspecified', category: 'Kulit'),
    Icd10Item(code: 'L70.0', description: 'Acne vulgaris', category: 'Kulit'),
    
    // Neurologi
    Icd10Item(code: 'G43.9', description: 'Migraine, unspecified', category: 'Neurologi'),
    Icd10Item(code: 'G44.2', description: 'Tension-type headache', category: 'Neurologi'),
    Icd10Item(code: 'G40.9', description: 'Epilepsy, unspecified', category: 'Neurologi'),
    
    // Urologi & Ginekologi
    Icd10Item(code: 'N39.0', description: 'Urinary tract infection (ISK), site not specified', category: 'Urologi'),
    Icd10Item(code: 'N20.1', description: 'Calculus of ureter (Batu Ureter)', category: 'Urologi'),
    Icd10Item(code: 'N73.9', description: 'Female pelvic inflammatory disease', category: 'Ginekologi'),
    Icd10Item(code: 'O80', description: 'Single spontaneous delivery', category: 'Kebidanan'),
    
    // Mata & THT
    Icd10Item(code: 'H10.9', description: 'Conjunctivitis, unspecified', category: 'Mata'),
    Icd10Item(code: 'H66.9', description: 'Otitis media, unspecified', category: 'THT'),
    
    // Otot & Tulang
    Icd10Item(code: 'M19.9', description: 'Osteoarthritis, unspecified', category: 'Muskuloskeletal'),
    Icd10Item(code: 'M54.5', description: 'Low back pain', category: 'Muskuloskeletal'),
    Icd10Item(code: 'M79.1', description: 'Myalgia', category: 'Muskuloskeletal'),
    
    // Gejala Umum
    Icd10Item(code: 'R50.9', description: 'Fever, unspecified', category: 'Gejala Umum'),
    Icd10Item(code: 'R51', description: 'Headache', category: 'Gejala Umum'),
    Icd10Item(code: 'R10.4', description: 'Other and unspecified abdominal pain', category: 'Gejala Umum'),
    Icd10Item(code: 'R42', description: 'Dizziness and giddiness (Vertigo)', category: 'Gejala Umum'),
  ];

  var filteredList = <Icd10Item>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredList.assignAll(_fullDatabase);
    
    searchCtrl.addListener(() {
      final query = searchCtrl.text.toLowerCase();
      if (query.isEmpty) {
        filteredList.assignAll(_fullDatabase);
      } else {
        filteredList.assignAll(
          _fullDatabase.where((item) => 
            item.code.toLowerCase().contains(query) || 
            item.description.toLowerCase().contains(query) ||
            item.category.toLowerCase().contains(query)
          ).toList()
        );
      }
    });
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }
}

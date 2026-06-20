# RULE - KlinikTap
## Dasbor Telekonsultasi & Peresepan Digital (Sisi Dokter)

> Dokumen ini adalah **aturan arsitektur & teknis** untuk pengembangan aplikasi mobile **KlinikTap**.
> Companion document: `design-kliniktap.md` (berisi detail UI/UX, palet warna, tipografi, dan spesifikasi visual tiap komponen).
> Status proyek: **Front-end only / Demo Prototype** — tidak ada backend nyata, seluruh data bersumber dari mock JSON lokal.

---

## 1. Ringkasan Proyek

| Item | Detail |
|---|---|
| Nama Aplikasi | KlinikTap |
| Modul | Dasbor Telekonsultasi & Peresepan Digital — Sisi Dokter |
| Tipe Build | Front-end demo (UI/UX showcase, tanpa koneksi backend/API nyata) |
| Framework | Flutter (Dart) |
| Target Platform | Android & iOS (mobile only, tidak perlu responsive web/tablet) |
| State Management | GetX |
| Sumber Data | Mock JSON lokal (`assets/mock/*.json`) |
| Metodologi | Feature-Driven Development (FDD) |

---

## 2. Prinsip Arsitektur

1. **Feature-Driven Development (FDD)** — setiap fitur (Dasbor, Telekonsultasi, Peresepan, EMR, Profil & Jadwal) berdiri sebagai modul mandiri: punya folder sendiri berisi page, widget, controller, dan model lokalnya.
2. **GetX 3 pilar** dipakai konsisten di seluruh modul:
   - **State Management** → `GetxController` + `Rx` (Obx/GetBuilder) untuk reaktivitas (status online/offline dokter, langkah stepper resep, isi keranjang antrean, dsb).
   - **Route Management** → `GetPage` + `Get.toNamed()`, named routes terpusat di `app_routes.dart`.
   - **Dependency Injection** → `Get.lazyPut()` / `Get.put()` lewat `Binding` per halaman, agar controller hanya dibuat saat halaman dibuka.
3. **Karena front-end only**, tidak ada lapisan network (Dio/http). Yang ada adalah **Mock Repository Layer** yang membaca file JSON dari folder `assets/mock/`, di-parse ke model Dart, dan dikembalikan via `Future.delayed(...)` untuk mensimulasikan latensi jaringan supaya animasi loading/shimmer tetap relevan didemokan.
4. **Widget granular** — setiap blok visual (kartu statistik, baris antrean, chip balasan cepat, choice chip dosis, dll.) dipecah jadi widget terpisah dan reusable di `lib/shared/widgets/`, bukan ditulis inline di dalam page. Tujuannya supaya page tetap pendek dan mudah dibaca, sesuai semangat "komponen interaktif" yang diminta.
5. **Animasi mulus native Flutter** — prioritaskan widget bawaan (`AnimatedContainer`, `Hero`, `SliverAppBar`, `AnimatedSwitcher`, `DraggableScrollableSheet`) dibanding package animasi pihak ketiga, kecuali untuk kasus spesifik (lihat daftar dependency).

---

## 3. Struktur Folder (FDD)

```
lib/
├── main.dart
├── app/
│   ├── app.dart                     # GetMaterialApp, theme, initial route
│   ├── routes/
│   │   ├── app_routes.dart          # konstanta nama route
│   │   └── app_pages.dart           # daftar GetPage + binding
│   └── theme/
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       └── app_theme.dart
│
├── core/
│   ├── constants/
│   │   └── asset_paths.dart         # path ke file mock JSON & gambar
│   ├── utils/
│   │   ├── date_formatter.dart
│   │   └── priority_color_helper.dart
│   └── services/
│       └── mock_data_service.dart   # service generik baca & parse JSON dari assets
│
├── data/
│   ├── models/
│   │   ├── doctor_model.dart
│   │   ├── patient_queue_model.dart
│   │   ├── chat_message_model.dart
│   │   ├── medicine_model.dart
│   │   ├── prescription_model.dart
│   │   ├── medical_record_model.dart
│   │   ├── vital_sign_model.dart
│   │   └── schedule_model.dart
│   └── repositories/
│       ├── dashboard_repository.dart
│       ├── teleconsult_repository.dart
│       ├── prescription_repository.dart
│       ├── medical_record_repository.dart
│       └── schedule_repository.dart
│
├── features/
│   ├── dashboard/
│   │   ├── controllers/dashboard_controller.dart
│   │   ├── bindings/dashboard_binding.dart
│   │   ├── views/dashboard_page.dart
│   │   └── widgets/
│   │       ├── dashboard_sliver_app_bar.dart
│   │       ├── stat_card.dart
│   │       ├── stat_card_list.dart
│   │       ├── queue_list_item.dart
│   │       └── priority_badge.dart
│   │
│   ├── teleconsultation/
│   │   ├── controllers/teleconsult_controller.dart
│   │   ├── bindings/teleconsult_binding.dart
│   │   ├── views/teleconsult_page.dart
│   │   └── widgets/
│   │       ├── video_call_panel.dart
│   │       ├── call_control_buttons.dart
│   │       ├── chat_panel.dart
│   │       ├── chat_bubble.dart
│   │       ├── quick_reply_chip_bar.dart
│   │       └── patient_vital_bottom_sheet.dart
│   │
│   ├── prescription/
│   │   ├── controllers/prescription_controller.dart
│   │   ├── bindings/prescription_binding.dart
│   │   ├── views/prescription_page.dart
│   │   └── widgets/
│   │       ├── prescription_stepper.dart
│   │       ├── medicine_autocomplete_field.dart
│   │       ├── medicine_suggestion_list.dart
│   │       ├── dosage_frequency_chips.dart
│   │       ├── dosage_timing_chips.dart
│   │       └── prescription_confirm_button.dart
│   │
│   ├── medical_record/
│   │   ├── controllers/medical_record_controller.dart
│   │   ├── bindings/medical_record_binding.dart
│   │   ├── views/medical_record_page.dart
│   │   └── widgets/
│   │       ├── patient_identity_card.dart
│   │       ├── record_expansion_panel.dart
│   │       ├── vital_trend_chart.dart
│   │       └── visit_timeline.dart
│   │
│   └── schedule_profile/
│       ├── controllers/schedule_profile_controller.dart
│       ├── bindings/schedule_profile_binding.dart
│       ├── views/schedule_profile_page.dart
│       └── widgets/
│           ├── doctor_identity_header.dart
│           ├── availability_switch.dart
│           ├── interactive_calendar.dart
│           ├── working_hours_sheet.dart
│           └── settings_menu_list.dart
│
└── shared/
    └── widgets/
        ├── app_loading_indicator.dart
        ├── app_empty_state.dart
        ├── app_avatar.dart
        └── app_primary_button.dart

assets/
├── mock/
│   ├── doctor.json
│   ├── patient_queue.json
│   ├── chat_messages.json
│   ├── medicines.json
│   ├── medical_records.json
│   ├── vital_signs.json
│   └── schedule.json
└── images/
    └── (avatar dummy, ikon, dsb.)
```

---

## 4. Modul & Spesifikasi Fungsional

### 4.1 Dasbor Utama (`features/dashboard`)
- **Header**: `SliverAppBar` dengan `expandedHeight`, berisi foto profil dokter (`AppAvatar`), teks sapaan, dan ikon lonceng notifikasi. Menyusut (`pinned: true`, `flexibleSpace`) saat discroll.
- **Ringkasan statistik**: `ListView` horizontal (`scrollDirection: Axis.horizontal`) berisi `StatCard` (antrean hari ini, resep diterbitkan, tugas selesai). Data dari `DashboardController.stats` (Rx list).
- **Daftar antrean**: `ListView.builder` vertikal, tiap baris (`QueueListItem`) menampilkan avatar pasien, nama, jam janji temu, `PriorityBadge` (warna sesuai level prioritas), dan tombol aksi cepat "Mulai Panggilan" yang mengarah ke `Get.toNamed(Routes.TELECONSULT, arguments: queue)`.
- **Controller state**: `RxList<PatientQueueModel> queueList`, `RxBool isLoading`, fetch dari `DashboardRepository` saat `onInit()`.

### 4.2 Telekonsultasi Terintegrasi (`features/teleconsultation`)
- Layout dibagi 2 area utama dalam `Column`:
  - **Atas (flex lebih besar)**: `VideoCallPanel` — placeholder video (`Container`/`AspectRatio` dengan gambar dummy), overlay `CallControlButtons` (mute mic, kamera, end call) pakai `Stack` + tombol transparan (`IconButton` di atas `Positioned`).
  - **Bawah**: `ChatPanel` — `ListView.builder` reverse untuk bubble chat (`ChatBubble`), `TextField` input, dan `QuickReplyChipBar` (`Wrap`/`ListView` horizontal berisi `ActionChip` template balasan).
- **Bottom sheet riwayat pasien**: `DraggableScrollableSheet` (`initialChildSize` kecil, bisa ditarik naik) menampilkan `PatientVitalBottomSheet` — riwayat alergi & diagnosis terakhir, dipicu lewat tombol atau gesture tarik dari tepi bawah.
- **Controller state**: `RxBool isMicOn`, `RxBool isCameraOn`, `RxList<ChatMessageModel> messages`, `RxList<String> quickReplies`.

### 4.3 Peresepan Cerdas / E-Prescription (`features/prescription`)
- Dibungkus `PrescriptionStepper` (gunakan `Stepper` bawaan Material atau custom stepper dengan `AnimatedSwitcher`) dengan 3 langkah: **Diagnosis → Pilih Obat → Konfirmasi**.
- **Langkah pilih obat**: `MedicineAutocompleteField` — `TextField` dengan `onChanged` yang memfilter `List<MedicineModel>` dari mock JSON, menampilkan `MedicineSuggestionList` sebagai overlay (`Overlay`/`CompositedTransformFollower` atau cukup `ListView` kondisional di bawah field).
- **Dosis**: tanpa input teks manual — `DosageFrequencyChips` (`ChoiceChip` group: 1x/2x/3x sehari) dan `DosageTimingChips` (`ChoiceChip` group: sebelum/sesudah makan). State dipilih disimpan di `Rx<String>` pada controller.
- **Konfirmasi**: `PrescriptionConfirmButton` — tombol besar full width, warna kontras (`ElevatedButton` dengan `minimumSize: Size.fromHeight(56)`), memicu simulasi pengiriman (`Future.delayed` + snackbar/dialog sukses via `Get.snackbar` atau `Get.dialog`).

### 4.4 Rekam Medis Elektronik / EMR (`features/medical_record`)
- **Kartu identitas**: `PatientIdentityCard` statis di atas (usia, tinggi, golongan darah, no. rekam medis) dari `MedicalRecordModel`.
- **Panel ekspansi**: `RecordExpansionPanel` membungkus `ExpansionPanelList` (Material) untuk riwayat keluarga, alergi, hasil pemeriksaan — collapsed by default, expand on tap.
- **Grafik tren vital**: `VitalTrendChart` — gunakan package chart ringan (lihat §6) untuk plot tekanan darah/metrik lain dari `List<VitalSignModel>`.
- **Timeline kunjungan**: `VisitTimeline` — `ListView.builder` custom dengan garis vertikal + dot (`CustomPaint` atau package timeline, lihat §6), tiap titik berisi tanggal & diagnosis singkat.

### 4.5 Profil & Manajemen Jadwal (`features/schedule_profile`)
- **Header**: `DoctorIdentityHeader` (foto, nama, spesialisasi) + `AvailabilitySwitch` (`Switch`/custom toggle besar) yang mengubah `RxBool isAvailable` pada controller, posisi mencolok di pojok.
- **Kalender interaktif**: `InteractiveCalendar` — gunakan `table_calendar` (lihat §6) penuh 1 bulan, tiap tanggal diberi indikator warna (penuh/kosong) lewat `calendarBuilders`. Tap tanggal → buka `WorkingHoursSheet` (`showModalBottomSheet`) untuk atur jam kerja hari itu.
- **Menu bawah**: `SettingsMenuList` — `ListView` standar (`ListTile`) ke Keamanan Akun, Pusat Bantuan, Logout (logout cukup `Get.offAllNamed(Routes.LOGIN)` simulatif, tanpa auth nyata).

---

## 5. Aturan Mock Data (Front-End Only)

1. Semua data mentah disimpan sebagai file `.json` statis di `assets/mock/`, **didaftarkan di `pubspec.yaml`**.
2. `MockDataService` (di `core/services/`) bertugas generik: `Future<dynamic> loadJson(String path)` — membaca via `rootBundle.loadString()` lalu `jsonDecode()`.
3. Setiap `*_repository.dart` memanggil `MockDataService`, mem-parsing ke model (`fromJson`), dan **selalu dibungkus `Future.delayed(Duration(milliseconds: 600–1000))`** untuk mensimulasikan loading state — supaya shimmer/`AppLoadingIndicator` punya kesempatan tampil saat demo.
4. **Tidak ada package http/dio.** Tidak ada `.env`, tidak ada base URL, tidak ada autentikasi token nyata.
5. Aksi "tulis data" (kirim resep, ubah jadwal, kirim chat) **tidak benar-benar persist** — cukup update state lokal (`RxList`/`Rx`) di controller agar UI terasa hidup, lalu opsional tampilkan `Get.snackbar` sebagai feedback sukses.
6. Setiap model wajib punya constructor `fromJson(Map<String, dynamic> json)` agar konsisten dan mudah diganti ke API asli di masa depan tanpa mengubah struktur UI.

---

## 6. Dependency yang Diizinkan

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6                # state management, routing, DI
  table_calendar: ^3.1.2     # kalender interaktif Profil & Jadwal
  fl_chart: ^0.69.0          # grafik tren vital EMR
  intl: ^0.19.0              # format tanggal/jam (Bahasa Indonesia)
  cached_network_image: ^3.4.1  # avatar dummy (opsional, jika pakai URL gambar)
```

> Catatan: hindari menambah package baru di luar daftar ini tanpa alasan kuat. Prioritaskan widget bawaan Flutter (`SliverAppBar`, `DraggableScrollableSheet`, `ExpansionPanelList`, `Stepper`, `ChoiceChip`, `Switch`) sebelum mencari package pihak ketiga.

---

## 7. Konvensi Penamaan & Penulisan Kode

- **File & folder**: `snake_case.dart`.
- **Class**: `PascalCase` — Controller selalu diakhiri `Controller` (`DashboardController`), Binding diakhiri `Binding`, Model diakhiri `Model`.
- **Widget privat dalam satu file** boleh diawali underscore (`_buildHeader()`), tapi **widget yang dipakai lintas halaman wajib jadi `StatelessWidget`/`StatefulWidget` terpisah** di folder `widgets/`.
- **Page** hanya berisi layout/komposisi widget — **tidak boleh ada logic bisnis** (filtering, kalkulasi, parsing) langsung di page; semua logic ada di Controller.
- **Reaktivitas**: gunakan `Obx(() => ...)` untuk widget kecil yang reaktif, hindari membungkus seluruh page dalam satu `Obx` besar (agar rebuild lebih efisien).
- **Warna & style**: tidak boleh hardcode `Color(0xFF...)` di widget — selalu ambil dari `AppColors` (didefinisikan sesuai palet di `design-kliniktap.md`).
- **Validasi pesan & label UI**: seluruh teks antarmuka, placeholder, dan pesan status menggunakan **Bahasa Indonesia**.

---

## 8. Routing (GetX Named Routes)

```dart
abstract class Routes {
  static const DASHBOARD = '/dashboard';
  static const TELECONSULT = '/teleconsult';
  static const PRESCRIPTION = '/prescription';
  static const MEDICAL_RECORD = '/medical-record';
  static const SCHEDULE_PROFILE = '/schedule-profile';
}
```

- Navigasi antar fitur memakai `Get.toNamed()` / `Get.offNamed()` dengan `arguments` untuk mengoper data (mis. pasien yang dipilih dari antrean ke halaman Telekonsultasi).
- Bottom navigation utama (jika ada) mengelola 5 tab: Dasbor, Telekonsultasi (kondisional/hidden jika tidak ada sesi aktif), Peresepan, EMR, Profil — direkomendasikan pakai `IndexedStack` + `GetX<NavController>` agar state tiap tab tidak hilang saat pindah tab.

---

## 9. Batasan Eksplisit (Demo Front-End)

- ❌ Tidak ada autentikasi nyata (login cukup simulasi, boleh skip langsung ke Dasbor).
- ❌ Tidak ada koneksi video call nyata (WebRTC/Agora/dsb.) — `VideoCallPanel` cukup placeholder visual + animasi dummy.
- ❌ Tidak ada penyimpanan database lokal (tidak perlu Hive/SQLite) — cukup state in-memory selama sesi app berjalan.
- ❌ Tidak perlu push notification nyata — ikon lonceng cukup menampilkan badge/list dummy.
- ✅ Fokus utama: **kualitas interaksi UI, kehalusan animasi, dan kelengkapan alur visual** sesuai 5 modul di atas.

---

## 10. Referensi Silang

- Detail visual (palet warna, tipografi, spacing, shadow, elevation, micro-interaction) → lihat `design-kliniktap.md`.
- Setiap penambahan fitur baru wajib mengikuti pola folder FDD di §3 dan aturan mock data di §5 sebelum penulisan kode dimulai.

# DESIGN - KlinikTap
## Dasbor Telekonsultasi & Peresepan Digital (Sisi Dokter)

> Companion document dari `rule-kliniktap.md`. Dokumen ini berisi spesifikasi **visual**: palet warna, tipografi, spacing, komponen, dan detail desain tiap halaman. Tujuannya agar implementasi UI konsisten tanpa harus menebak-nebak nilai desain saat coding.

---

## 1. Konsep Visual

**Tema**: *"Clinical Clarity"* — antarmuka medis yang tenang, profesional, dan cepat dipindai mata saat dokter sedang sibuk. Kontras tinggi pada elemen aksi (tombol panggilan, konfirmasi resep), tapi latar tetap lembut dan tidak melelahkan mata untuk pemakaian jangka panjang.

**Mood**: tenang — terpercaya — efisien. Hindari warna mencolok berlebihan kecuali untuk indikator status (prioritas, ketersediaan, peringatan).

---

## 2. Palet Warna

```dart
class AppColors {
  // Primary — Teal medis, identitas utama KlinikTap
  static const primary = Color(0xFF0D7377);
  static const primaryLight = Color(0xFF14A8AC);
  static const primaryDark = Color(0xFF075759);
  static const primarySurface = Color(0xFFE6F5F5);

  // Secondary — Biru kalem untuk elemen pendukung (chat, info)
  static const secondary = Color(0xFF3A6EA5);
  static const secondarySurface = Color(0xFFEAF1F8);

  // Accent — untuk tombol aksi utama yang harus mencolok (kirim resep, mulai panggilan)
  static const accent = Color(0xFFFF6B35);
  static const accentSurface = Color(0xFFFFF0E8);

  // Status Prioritas Antrean
  static const priorityHigh = Color(0xFFE63946);     // merah — gawat darurat
  static const priorityMedium = Color(0xFFFFA630);   // oranye — urgent
  static const priorityLow = Color(0xFF2A9D8F);      // hijau toska — rutin

  // Status Ketersediaan Dokter
  static const statusOnline = Color(0xFF2EC4B6);
  static const statusOffline = Color(0xFF9CA3AF);

  // Status Jadwal Kalender
  static const calendarFull = Color(0xFFE63946);
  static const calendarAvailable = Color(0xFF2A9D8F);
  static const calendarPartial = Color(0xFFFFA630);

  // Netral / Teks / Latar
  static const background = Color(0xFFF7F9FA);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF1A2B2C);
  static const textSecondary = Color(0xFF5C6B6C);
  static const textHint = Color(0xFF9AA5A6);
  static const border = Color(0xFFE2E8E8);
  static const divider = Color(0xFFEDF2F2);

  // Semantic
  static const success = Color(0xFF2A9D8F);
  static const warning = Color(0xFFFFA630);
  static const error = Color(0xFFE63946);
  static const info = Color(0xFF3A6EA5);
}
```

**Aturan pemakaian:**
- `primary` dipakai untuk app bar, tombol sekunder, ikon aktif.
- `accent` (oranye) **hanya** untuk satu tombol aksi paling penting per halaman (CTA tunggal) — jangan dipakai berulang dalam satu layar agar tetap punya daya tarik visual.
- Warna prioritas/status **tidak boleh** dipakai sebagai warna dekoratif biasa — selalu merepresentasikan data (badge, dot, border-left kartu).

---

## 3. Tipografi

**Font**: `Plus Jakarta Sans` (via `google_fonts` atau bundling lokal) — clean, modern, mudah dibaca di layar kecil.

```dart
class AppTextStyles {
  static const fontFamily = 'PlusJakartaSans';

  static const h1 = TextStyle(fontSize: 26, fontWeight: FontWeight.w700, height: 1.3);
  static const h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w700, height: 1.3);
  static const h3 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.35);
  static const subtitle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.4);
  static const body = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5);
  static const bodySmall = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.4);
  static const caption = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, height: 1.3);
  static const button = TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.2);
}
```

- Statistik angka besar di `StatCard` pakai varian khusus: `fontSize: 28, fontWeight: FontWeight.w800`.
- Semua label form, tombol, dan pesan validasi dalam **Bahasa Indonesia**.

---

## 4. Spacing, Radius & Elevation

```dart
class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

class AppRadius {
  static const card = 16.0;
  static const button = 12.0;
  static const chip = 20.0;       // pill shape
  static const bottomSheet = 24.0; // hanya top-left & top-right
  static const avatar = 100.0;    // full circle
}
```

- **Elevation/shadow**: gunakan soft shadow, bukan `Material elevation` default yang keras.
  ```dart
  BoxShadow(
    color: Colors.black.withOpacity(0.06),
    blurRadius: 16,
    offset: Offset(0, 4),
  )
  ```
- Padding standar konten halaman: `EdgeInsets.symmetric(horizontal: 16)`.
- Jarak antar section vertikal: `24px`.

---

## 5. Spesifikasi per Halaman

### 5.1 Dasbor Utama

| Elemen | Spesifikasi |
|---|---|
| `SliverAppBar` | `expandedHeight: 180`, `pinned: true`, background gradient `primary → primaryDark`, collapse menampilkan hanya foto profil kecil + judul "Dasbor" |
| Foto profil & sapaan | Avatar 56px (expanded) menyusut ke 36px (collapsed), teks "Selamat Pagi, dr. [Nama]" — `h3` warna putih |
| Ikon notifikasi | `IconButton` lonceng di kanan atas, badge merah kecil (`accent`/`error`) jika ada notifikasi belum dibaca |
| `StatCard` | Lebar tetap 140px, tinggi 100px, radius `card`, background `surface`, border-left 4px warna sesuai jenis statistik (primary/secondary/accent). Angka besar di atas, label kecil di bawah |
| `QueueListItem` | Card radius `card`, padding `md`, avatar 48px kiri, di tengah nama (`subtitle`) + jam (`bodySmall`, `textSecondary`), `PriorityBadge` (dot 8px + label) kanan atas, tombol ikon video call (`accent` circle button) kanan bawah |
| Empty state | Jika antrean kosong: ilustrasi sederhana + teks "Belum ada antrean hari ini" |

### 5.2 Telekonsultasi Terintegrasi

| Elemen | Spesifikasi |
|---|---|
| Rasio layar | Area video : area chat ≈ `55 : 45` dari tinggi layar (gunakan `Expanded(flex: 11)` dan `flex: 9`) |
| `VideoCallPanel` | Background gelap (`#1A2B2C`), placeholder foto pasien membulat di tengah jika kamera "mati", label durasi panggilan pojok kiri atas (`bodySmall`, putih, background semi-transparan hitam) |
| `CallControlButtons` | 3 tombol bulat 52px melayang di bawah video: mic (toggle abu/merah), kamera (toggle abu/merah), akhiri panggilan (selalu merah solid) |
| `ChatPanel` | Background `background`, bubble dokter rata kanan (`primary`, teks putih), bubble pasien rata kiri (`surface` + `border`, teks `textPrimary`) |
| `QuickReplyChipBar` | `ActionChip` pill (`chip` radius), background `primarySurface`, teks `primary`, horizontal scroll, contoh isi: "Baik, saya cek dulu", "Mohon tunggu sebentar", "Bisa kirim foto?" |
| `PatientVitalBottomSheet` | `DraggableScrollableSheet` radius atas `bottomSheet`, handle bar abu-abu 40x4px di tengah atas, konten: chip alergi (background `error` opacity 10%), diagnosis terakhir dalam card kecil |

### 5.3 Peresepan Cerdas

| Elemen | Spesifikasi |
|---|---|
| `PrescriptionStepper` | 3 step dengan connector line, step aktif warna `primary`, step selesai centang hijau (`success`), step belum aktif abu (`textHint`) |
| `MedicineAutocompleteField` | `TextField` radius `button`, border `border`, ikon search kiri, saat fokus border berubah `primary` 1.5px |
| `MedicineSuggestionList` | Muncul tepat di bawah field, card melayang (shadow soft), tiap item: nama obat (`body` bold) + kategori/dosis umum (`bodySmall`, `textSecondary`), max tinggi 240px lalu scroll |
| `DosageFrequencyChips` / `DosageTimingChips` | `ChoiceChip`, unselected: background `surface` + border `border`, selected: background `primary`, teks putih, radius `chip` |
| `PrescriptionConfirmButton` | Full width, tinggi 56px, background `accent`, radius `button`, teks putih `button` style, shadow accent opacity 30% |

### 5.4 Rekam Medis Elektronik

| Elemen | Spesifikasi |
|---|---|
| `PatientIdentityCard` | Background gradient lembut `primarySurface → surface`, layout grid 2 kolom (label kecil di atas, value bold di bawah) untuk usia/tinggi/golongan darah/no. RM |
| `RecordExpansionPanel` | Header collapsed: ikon kategori (kiri) + judul (`subtitle`) + chevron kanan. Expanded: background `background`, konten list `bodySmall` dengan bullet |
| `VitalTrendChart` | `fl_chart` line chart, warna garis `primary`, area di bawah garis gradient `primary` opacity 15% ke transparan, grid garis tipis `divider` |
| `VisitTimeline` | Garis vertikal 2px warna `border`, dot 12px warna `primary` (atau `error` jika kunjungan darurat) per titik, tanggal (`bodySmall` bold) + diagnosis singkat (`body`) di kanan tiap dot |

### 5.5 Profil & Manajemen Jadwal

| Elemen | Spesifikasi |
|---|---|
| `DoctorIdentityHeader` | Avatar 72px kiri, nama (`h3`) + spesialisasi (`bodySmall`, `textSecondary`) di kanan |
| `AvailabilitySwitch` | Custom toggle besar (bukan `Switch` kecil bawaan) — pill 64x32px, posisi kanan atas header, ON: background `statusOnline` + label "Aktif", OFF: background `statusOffline` + label "Istirahat" |
| `InteractiveCalendar` (`table_calendar`) | `headerStyle` minimalis (panah kiri/kanan tipis), tanggal hari ini: border `primary` 1.5px, tanggal penuh: dot bawah `calendarFull`, tanggal tersedia: dot `calendarAvailable`, tanggal terpilih: background `primary` solid teks putih |
| `WorkingHoursSheet` | `showModalBottomSheet` radius `bottomSheet`, berisi time picker jam buka/tutup + toggle "Tutup hari ini" |
| `SettingsMenuList` | `ListTile` standar, ikon kiri (`textSecondary`), judul `body`, chevron kanan, divider tipis antar item, item "Keluar" teks warna `error` |

---

## 6. Komponen Reusable Global (`shared/widgets`)

| Komponen | Catatan Visual |
|---|---|
| `AppLoadingIndicator` | `CircularProgressIndicator` warna `primary`, ukuran 28px, dipakai saat fetch mock data |
| `AppEmptyState` | Ikon outline besar (`textHint`) + teks `bodySmall` `textSecondary`, center |
| `AppAvatar` | Circle, border 2px `surface` + shadow tipis jika di atas gambar/gradient |
| `AppPrimaryButton` | Reusable untuk semua CTA besar, parameter warna agar bisa dipakai `primary` atau `accent` sesuai konteks |
| `PriorityBadge` | Dot 8px + label kapital kecil, warna dari `priorityHigh/Medium/Low` |

---

## 7. Motion & Animasi

| Interaksi | Animasi |
|---|---|
| `SliverAppBar` collapse | Native scroll-driven, tanpa custom curve tambahan |
| Pindah step `PrescriptionStepper` | `AnimatedSwitcher` dengan `FadeTransition` + `SlideTransition` (durasi 250ms, curve `easeInOut`) |
| Buka `ExpansionPanel` | Default Material expand/collapse, durasi 200ms |
| `DraggableScrollableSheet` muncul | Native drag, snap point di 0.15 / 0.5 / 0.9 |
| `ChoiceChip` selected | `AnimatedContainer` 150ms untuk transisi warna background |
| Toggle `AvailabilitySwitch` | `AnimatedAlign` untuk thumb pill, durasi 200ms `easeOut` |
| Tombol ditekan | `AnimatedScale` ke 0.97 selama 100ms (feedback tactile ringan) |

---

## 8. Ikonografi

- Gunakan **Material Symbols / Icons** bawaan Flutter (`Icons.*`) — konsisten, tanpa perlu package ikon tambahan.
- Style outline untuk ikon non-aktif, filled untuk ikon aktif/terpilih (mis. bottom navigation).
- Ukuran standar: 24px (umum), 20px (di dalam chip/badge), 28px (header/aksi utama).

---

## 9. Referensi Silang

- Struktur folder, state management, dan aturan mock data → lihat `rule-kliniktap.md`.
- Dokumen ini adalah sumber kebenaran tunggal untuk nilai warna, font, spacing, dan radius — semua widget di `lib/` wajib mengacu ke sini, tidak boleh hardcode nilai baru tanpa mengupdate dokumen ini terlebih dahulu.

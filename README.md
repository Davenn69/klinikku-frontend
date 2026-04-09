# Klinikku Flutter App

Klinikku adalah aplikasi Flutter dengan arsitektur feature-based modular, state management menggunakan Riverpod, navigasi memakai GoRouter, penyimpanan lokal dengan Hive, dan dukungan environment via `envied`.

## Tech Stack

- Flutter
- Riverpod
- GoRouter
- Hive / Hive Flutter
- Dio
- ScreenUtil
- OKToast
- Envied

## Arsitektur Project

Proyek ini menggunakan arsitektur **MVVM (Model, View, ViewModel)** dengan pendekatan feature-based modular. Tujuannya adalah memisahkan UI, logika presentasi, dan data supaya kode lebih mudah dirawat, lebih gampang diuji, dan lebih enak dikembangkan saat fitur bertambah.

Secara sederhana:

- **Model** menyimpan bentuk data dan struktur response/request.
- **View** bertugas menampilkan UI dan menerima interaksi pengguna.
- **ViewModel** menjadi penghubung antara View dan data, termasuk menjalankan logika bisnis ringan, validasi, state management, dan pemanggilan service.

Di project ini, pola tersebut dipadukan dengan pembagian folder per fitur. Jadi setiap fitur punya struktur sendiri, tetapi tetap memakai komponen inti dari `lib/cores`.

Struktur project dibagi menjadi dua bagian utama:

- `lib/cores`
- `lib/features`

### `lib/cores`

Berisi komponen yang dipakai lintas fitur, seperti:

- `bases`: base class untuk view, notifier, form notifier, dan services
- `configs`: konfigurasi environment dan flavor
- `constants`: theme, colors, text style, icon, image, dan button theme
- `router`: konfigurasi routing aplikasi
- `utils`: helper untuk Hive, string extension, dan interceptor
- `widgets`: reusable widget seperti button, text field, toast, loading indicator
- `mixins`: helper mixin yang dipakai di banyak feature

### `lib/features`

Berisi modul per fitur aplikasi. Contohnya:

- `auth`
- `splash`
- `dashboard`
- `booking`

Setiap fitur umumnya dipisah lagi menjadi:

- `views`
- `viewmodels`
- `services`
- `models`
- `widgets`

### Alur Aplikasi

1. `main.dart` melakukan bootstrap awal
2. Hive diinisialisasi
3. `ScreenUtil` disiapkan
4. Environment dibaca dari `--dart-define=ENV=...`
5. Router dibuat dengan `GoRouter`
6. Aplikasi masuk ke `SplashView`
7. Dari splash, aplikasi mengecek session dan mengarahkan ke login atau dashboard

## Setup Project

### 1. Install dependency

```bash
flutter pub get
```

### 2. Pastikan file environment tersedia

Project ini memakai file:

- `.env.stage`
- `.env.prod`

Keduanya dipakai oleh `envied` untuk membaca:

- `BASE_URL`
- `SHOW_BANNER`

Jika isi environment berubah, generate ulang file env:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Pastikan asset sudah tersedia

Project ini memakai asset berikut:

- `assets/images/Klinikku.png`
- `assets/icons/`
- `assets/images/`
- font `DMSerif` dan `DMSans`

## Cara Menjalankan

### Android

Run staging:

```bash
flutter run --flavor staging
```

Run production:

```bash
flutter run --flavor production
```

### iOS

Run dengan environment tertentu:

```bash
flutter run --dart-define=ENV=staging
```

Build iOS:

```bash
flutter build ios --dart-define=ENV=production
```

## Icon dan Splash

Project ini menggunakan:

- native splash screen Android dan iOS
- app icon yang di-generate dari `assets/images/Klinikku.png`

Kalau ikon atau splash berubah, lakukan:

```bash
flutter clean
flutter pub get
flutter run
```

Jika masih melihat icon lama, uninstall aplikasi dari device/emulator lalu install ulang.

## Catatan Penting

- Jangan edit `lib/cores/configs/env.g.dart` secara manual karena file itu hasil generate.
- Jika menambah route baru, daftarkan di `lib/cores/router/router.dart` dan `lib/cores/router/route_constant.dart`.
- Jika menambah asset atau font baru, update `pubspec.yaml`.

# **Game & Quotes Apps**

Game & Quotes Apps adalah aplikasi berbasis Flutter yang menggabungkan game interaktif dengan Fitur kutipan. Pemain akan menebak kategori dari sebuah gambar dan dapat menambahkan atau mengelola kutipan mereka sendiri.

## MobilePrograming_Assignment1

  - Nama: Lalu Aldo Wadagraprana
  - NRP: 5025221101
  - Kelas: Pemrograman Perangkat Bergerak B
  - Dosen: Agus Budi Raharjo, S.Kom, M.Kom., Ph.D.
    
Tugas Pemrograman Perangkat Bergerak B - Membuat Aplikasi Sederhana Berbasis Flutter dengan StatefullWidget, StatelessWidget, custom class, Apply create, read, update, delete.

## Fitur Utama

  - Game Tebak Kategori → Pilih kategori gambar yang benar dan dapatkan skor.
  - Animasi Interaktif → Tombol akan bergoyang saat salah dan membesar saat benar.
  - Manajemen Kutipan → Tambahkan, edit, dan hapus kutipan inspiratif.
  - State Management dengan Provider → Mengelola status permainan dengan efisien.
  - Desain Responsif & Modern → UI bersih dengan tema biru yang menarik.

## Teknologi yang Digunakan

  - Flutter → Framework utama untuk pengembangan aplikasi.
  - Provider → Untuk state management yang efisien.
  - Material Design → UI berbasis Flutter Material.

## Perubahan Terbaru: Migrasi ke ObjectBox

Pada versi sebelumnya, data kutipan (Quotes) hanya disimpan di dalam list lokal tanpa persistent storage. Kini, aplikasi telah di-upgrade menggunakan database lokal ObjectBox untuk menyimpan data secara permanen bahkan setelah aplikasi ditutup.

### Tujuan Perubahan

  - Menyediakan penyimpanan persisten untuk data kutipan.
  - Menambahkan fitur CRUD berbasis database.
  - Meningkatkan skalabilitas aplikasi untuk menyimpan lebih banyak data.

### Perubahan Teknis yang Dilakukan

|            Perubahan              |                                             Keterangan                                                                |
| :-------------------------------: | :-------------------------------------------------------------------------------------------------------------------: |
| Penambahan Model Entity           | Menambahkan anotasi @Entity() pada Quote di quote.dart untuk membuat model database ObjectBox.                        |
| Penambahan File ObjectBox Service | Membuat objectbox_service.dart sebagai service class untuk mengelola operasi database (getAll, add, update, delete).  |
| Globalisasi Instance ObjectBox    | Menambahkan file globals.dart untuk menyimpan instance objectBox secara global.                                       |
| Inisialisasi Awal ObjectBox       | Fungsi _initObjectBox() ditambahkan di main.dart untuk menginisialisasi ObjectBox sebelum masuk ke tampilan utama.    |
| Update di MainScreen              | Semua aksi CRUD pada kutipan sekarang terhubung ke database ObjectBox, bukan list lokal biasa.                        |
| Refactor Struktur Folder          | Menyesuaikan folder models/ dan services/ untuk memisahkan data dan logika bisnis.                                    |


## Struktur Proyek Sebelumnya
```
lib/
├── main.dart                  # Entry point aplikasi
├── screens/
│   ├── main_screen.dart       # Tampilan utama aplikasi
├── widgets/
│   ├── game_buttons.dart      # Widget tombol permainan
│   ├── image_display.dart     # Widget tampilan gambar
│   ├── quote_card.dart        # Widget kartu kutipan
├── models/
│   ├── quote.dart             # Model data kutipan
├── services/
│   ├── game_service.dart      # Logika utama permainan
├── utils/
│   ├── snackbar_helper.dart   # Helper untuk snackbar (notifikasi)
```

## Update Struktur Proyek
```
lib/
├── main.dart                      # Entry point aplikasi dan inisialisasi ObjectBox
├── screens/
│   ├── main_screen.dart           # Tampilan utama aplikasi
├── widgets/
│   ├── game_buttons.dart          # Widget tombol permainan
│   ├── image_display.dart         # Widget tampilan gambar
│   ├── quote_card.dart            # Widget kartu kutipan
├── models/
│   ├── quote.dart                 # Model data kutipan dengan @Entity (ObjectBox)
│   ├── globals.dart               # Global variable: ObjectBoxService instance
├── services/
│   ├── game_service.dart          # Logika utama permainan
│   ├── objectbox_service.dart     # Logika CRUD untuk database ObjectBox
├── utils/
│   ├── snackbar_helper.dart       # Helper untuk snackbar (notifikasi)
├── objectbox.g.dart               # Generated file ObjectBox
```

## Hal-Hal yang Dilakukan

  - Tambahkan Dependencies di `pubspec.yaml`
      ```
        dependencies:
          objectbox: ^4.1.0
          objectbox_flutter_libs: any
          # If you run the command for ObjectBox Sync it should add instead:
          # objectbox_sync_flutter_libs: any
      
        dev_dependencies:
          build_runner: ^2.0.0
          objectbox_generator: any
      ```
  - Tambahkan Dependencies di `android/app/build.gradle.kts`
      ```
        android {
          ndkVersion = "27.0.12077973" # ini diubah yang semulanya --> flutter.ndkVersion
      ```
  - Jalankan
      ```
        flutter clean
        flutter pub get
        flutter pub run build_runner build --delete-conflicting-outputs
        flutter run
      ```

## Tampilan Aplikasi

`Tamppilan Awal`

![image](https://github.com/user-attachments/assets/1a71d658-5db3-4773-9a65-30cbcd0ef7b6)

`Tapilan Ketika Benar dalam Game`

![image](https://github.com/user-attachments/assets/0f0adfcb-3f8b-4dd2-8180-549f9ffb2370)

`Tampilan Ketika Salah Dalam Game`

![image](https://github.com/user-attachments/assets/29893158-6db1-4707-8030-d3284c89a622)

`Tampilan Penambahkan Quote`

![image](https://github.com/user-attachments/assets/ecad4e9d-e5b7-43a9-a17f-42f046c1b2e3)

`Tampilan Megedit Quote`

![image](https://github.com/user-attachments/assets/fbe140ee-f86d-4bef-adbb-1ba55a954173)


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Cara Menjalankan Aplikasi

Pastikan Anda sudah menginstal Flutter dan menjalankan perintah berikut:

  - Clone repository ini
    ```
    git clone https://github.com/Wadagraprana/MobilePrograming_Assignment1.git
    cd MobilePrograming_Assignment1
    ```
  - Jalankan aplikasi
    ```
    flutter clean
    flutter pub get
    flutter run
    ```

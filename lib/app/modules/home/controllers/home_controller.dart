import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable untuk data di halaman Home
  final count = 0.obs; // Contoh counter
  final isLoading = false.obs; // Status loading
  final userName = ''.obs; // Contoh untuk nama pengguna

  @override
  void onInit() {
    super.onInit();
    // Panggil fungsi untuk memuat data awal
    fetchInitialData();
  }

  @override
  void onReady() {
    super.onReady();
    // Anda bisa menambahkan logika yang perlu dijalankan ketika halaman siap
  }

  @override
  void onClose() {
    super.onClose();
    // Bersihkan resource atau tutup stream jika ada
  }

  // Fungsi untuk menambah nilai counter
  void increment() => count.value++;

  // Fungsi untuk memuat data awal (contoh)
  Future<void> fetchInitialData() async {
    try {
      isLoading.value = true; // Tampilkan indikator loading
      // Simulasi proses pengambilan data (misalnya dari API atau database lokal)
      await Future.delayed(const Duration(seconds: 2));
      userName.value = 'John Doe'; // Ganti dengan data yang Anda ambil
    } catch (e) {
      // Tangani error jika ada
      print('Error fetching initial data: $e');
    } finally {
      isLoading.value = false; // Sembunyikan indikator loading
    }
  }
}

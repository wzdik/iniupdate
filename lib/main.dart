import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedelai_hub/app/modules/auth/auth_controller.dart';
import 'package:kedelai_hub/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/routes/app_pages.dart';

void main() async {
  // Inisialisasi Flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi SharedPreferences dan simpan di Get untuk akses global
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences);

  // Inisialisasi AuthController
  final AuthController authController = Get.put(AuthController());

  // Tunggu proses autentikasi selesai
  await authController.checkLoginStatus();

  // Jalankan aplikasi
  runApp(
    GetMaterialApp(
      title: "Kedelai Hub",
      initialRoute: authController.isLoggedIn.value ? Routes.HOME : Routes.LOGIN,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

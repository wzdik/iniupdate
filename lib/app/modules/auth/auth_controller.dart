// import 'package:dhafs_app/app/modules/home/views/home_view.dart';
import 'package:kedelai_hub/app/modules/login/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    isLoggedIn.value = _prefs.containsKey('user_token');
  }

  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _prefs.setString('user_token', _auth.currentUser!.uid);
      Get.snackbar(
        'Success',
        'Registration successful', /*backgroundColor: Colors.grey*/
      );
      Get.off(LoginView()); // Navigasi ke halaman Login
    } catch (error) {
      Get.snackbar(
        'Error',
        'Registration failed: $error', /*backgroundColor: Colors.grey*/
      );
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _prefs.setString(
          'user_token', _auth.currentUser!.uid); // Simpan token pengguna
      Get.snackbar(
        'Success',
        'Login berhasil', /*backgroundColor: Colors.grey*/
      );
      isLoggedIn.value = true; // Set status login menjadi true
      Get.offAllNamed(
          '/home'); // Navigasi ke halaman Home dan hapus semua halaman sebelumnya
    } catch (error) {
      Get.snackbar(
        'Error',
        'Login gagal: $error', /*backgroundColor: Colors.grey*/
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    _prefs.remove('user_token');
    isLoggedIn.value = false;
    _auth.signOut();
    Get.offAllNamed('/login');
  }
}

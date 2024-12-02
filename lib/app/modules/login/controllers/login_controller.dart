import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedelai_hub/app/modules/auth/auth_controller.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Information!', 'Please enter email and password.');
      return;
    }

    await _authController.loginUser(email, password);

    // if (email == "user@mail.com" && password == "user") {
    //   Get.snackbar('Login Berhasil', "Welcome to Dhaf's Cakees");
    //   Get.toNamed('/home');
    // } else {
    //   Get.snackbar('Login gagal', 'Harap Cek Email dan Password Anda');
    // }
  }

  bool getIsloading() {
    return _authController.isLoading.value;
  }
}

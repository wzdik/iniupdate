import 'package:get/get.dart';
import 'package:kedelai_hub/app/modules/register/bindings/register_binding.dart';
import 'package:kedelai_hub/app/modules/register/views/register_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart'; // Berisi konstanta rute

class AppPages {
  AppPages._();

  // Rute awal aplikasi
  static const INITIAL = Routes.LOGIN;

  // Daftar rute aplikasi
  static final routes = [
    // Halaman Home
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    // Halaman Login
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    // Halaman Register
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
  ];
}

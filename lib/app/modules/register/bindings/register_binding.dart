import 'package:get/get.dart';
// import 'package:kedelai_hub/app/modules/login/controllers/login_controller.dart';
import 'package:kedelai_hub/app/modules/register/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
  }
}

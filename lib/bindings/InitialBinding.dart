import 'package:get/get.dart';

import '../controller/result_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultController(), fenix: true);
  }
}

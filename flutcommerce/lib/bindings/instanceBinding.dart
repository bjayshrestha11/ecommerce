import 'package:flutcommerce/helpers/firebaseAuth.controller.dart';
import 'package:get/get.dart';

class InstanceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FirebaseAuthController>(() => FirebaseAuthController());
  }

}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/api.dart';
import '../models/user_res_model.dart';
import '../screens/login_screen.dart';

class ProfileController extends GetxController {
  final _api = NetworkService();
  final box = GetStorage();
  UserResModel? profile;
  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  void getProfile() async{
    try {
      final response = await _api.me();
      profile = response;
      print("response: ${response.user!.email}");
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    box.remove('access_token');
    Get.offAll(() => const LoginScreen());
  }
}


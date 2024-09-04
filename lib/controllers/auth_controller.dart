import 'package:clone_ig/screens/authentication.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../api/api.dart';
import '../screens/main_screeen.dart';

class AuthController extends GetxController {
  File? profileImage;
  final imagePicker = ImagePicker();
  final _authService = NetworkService();
  final box = GetStorage();

  bool _isHidden = true;

  bool get isHidden => _isHidden;

  void toggleVisibility() {
    _isHidden = !_isHidden;
    update();
  }

  void selectProfileImage() async {
    final pickerFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      update();
    }
  }

  void signup({
    required String name,
    required email,
    required String password,
    required String password_confirmation,
  }) async {
    try {
      if (profileImage == null) {
        Get.snackbar("Message", "Please select profile image");
      }
      final response = await _authService.signup(
        name: name,
        email: email,
        password: password,
        password_confirmation: password_confirmation,
        profileImage: profileImage,
      );
      if (response == "success") {
        Get.offAll(() => Authentication());
      } else {
        Get.snackbar("Error", response);
      }
    } catch (e) {
      print("Error ${e}");
    }
  }

  void login({required String email, required String password}) async {
    try {
      final response =
          await _authService.login(email: email, password: password);
      box.write('access_token', response.accessToken);
      print("Response : ${response.accessToken}");
      Get.offAll(() => MainScreen());
    } catch (e) {
      print("Error ${e}");
    }
  }
}

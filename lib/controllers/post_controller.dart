import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../api/api.dart';
import '../screens/main_screeen.dart';

class PostController extends GetxController {
  File? image;
  final imagePicker = ImagePicker();
  final _authService = NetworkService();

  void selectPhoto() async {
    final pickerFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      image = File(pickerFile.path);
      update();
    }
  }

  void createPost({required String caption, required File photo}) async {
    try {
      final status =
          await _authService.createPost(caption: caption, photo: photo);
      if (status) {
        Get.back(result: true);
        Get.offAll(() => MainScreen());
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Something went wrong!',
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: e.toString(),
      );
    }
  }
}


import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../screens/main/ReelScreen.dart';
import '../screens/main/home_screen.dart';
import '../screens/main/post_screen.dart';
import '../screens/main/profile_screen.dart';
import '../screens/main/search_screen.dart';

class MainController extends GetxController {
  final box = GetStorage();
  final lstScreen = [
    HomeScreen(),
    const SearchScreen(),
    const PostScreen(),
    const ReelScreen(),
    ProfileScreen(),
  ];
  var currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}

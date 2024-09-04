import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import '../constants/constant.dart';
import '../controllers/profile_controller.dart';
import '/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main/post_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final _controller = Get.put(MainController());
  final _controllerProfile = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return Scaffold(
        body: _controller.lstScreen[_controller.currentIndex],
        bottomNavigationBar: _controller.currentIndex == 2
            ? Container()
            : BottomNavigationBar(
                currentIndex: _controller.currentIndex,
                onTap: (index) {
                  _controller.changeIndex(index);
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.search),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: IconButton(
                      onPressed: () {
                        Get.to(() => const PostScreen(),
                            transition: Transition.rightToLeft);
                      },
                      icon: Image.asset("assets/image/post.png",
                          width: 20, height: 20),
                    ),
                    label: "Post",
                  ),
                  BottomNavigationBarItem(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          _controller.currentIndex == 3
                              ? Colors.black
                              : Colors.grey,
                          BlendMode.srcIn),
                      child: Image.asset("assets/image/reels.png",
                          width: 20, height: 20),
                    ),
                    label: "Reels",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildProfile,
                    label: "Profile",
                  ),
                ],
              ),
      );
    });
  }

  Widget get _buildProfile {
    return GetBuilder<ProfileController>(
      builder: (_) {
        if(_controllerProfile.profile?.user?.profileUrl == null) {
          return CircleAvatar(
            radius: 11,
            child: Text(
              _controllerProfile.profile?.user?.name![0] ?? "",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return CircleAvatar(
          radius: 11,
          backgroundImage: CachedNetworkImageProvider(
              "$baseUrlProfile${_controllerProfile.profile?.user?.profileUrl}"),
        );
      }
    );
  }

  Widget _buildImageProfile() {
    return CachedNetworkImage(
      imageUrl: "https://picsum.photos/250?image=9",
      imageBuilder: (context, imageProvider) {
        return Container(
          margin: const EdgeInsets.all(5),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        );
      },
      placeholder: (context, url) => Container(
        color: Colors.grey[50],
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[200],
      ),
    );
  }
}

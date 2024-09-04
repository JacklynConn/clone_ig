import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/constant.dart';
import '../../controllers/profile_controller.dart';
import '../../elements/user_element.dart';
import '../../models/profile/follow_user.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "${_controller.profile?.user?.name}".toLowerCase(),
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
            ],
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: const Icon(Icons.add_box_outlined),
          //   ),
          //
          // ],
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  "Drawer Header",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text("Item 1"),
                onTap: () {},
              ),
              ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    _controller.logout();
                  },
                  child: const Text("Logout"),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _controller.profile?.user?.profileUrl == null
                              ? CircleAvatar(
                                  radius: 45,
                                  child: Text(
                                    _controller.profile?.user?.name![0] ?? "",
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 45,
                                  backgroundImage: CachedNetworkImageProvider(
                                    "$baseUrlProfile${_controller.profile?.user?.profileUrl ?? ""}",
                                  ),
                                ),
                          Text(
                            "${_controller.profile?.user?.name}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Column(
                        children: [
                          Text(
                            "2",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Posts"),
                        ],
                      ),
                      const Column(
                        children: [
                          Text(
                            "39",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Followers"),
                        ],
                      ),
                      const Column(
                        children: [
                          Text(
                            "435",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Following"),
                        ],
                      )
                    ],
                  ),
                  Text(
                    "${_controller.profile?.user?.shortBio ?? ""}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {},
                          child: const Text("Edit Profile",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {},
                          child: const Text("Share Profile",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        flex: 0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            fixedSize: const Size(10, 10),
                            elevation: 1,
                          ),
                          onPressed: () {},
                          child: const Icon(
                            Icons.person_add,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Discover People",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("See All"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: followUserList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Stack(
                            children: [
                              Container(
                                height: 240,
                                width: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      height: 120,
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                followUserList[index].image),
                                      ),
                                    ),
                                    Text(
                                      followUserList[index].name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      followUserList[index].follow,
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      width: 150,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Follow",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Story highlights",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Keep your favorite stories on your profile"),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                  Container(
                    height: 120,
                    // color: Colors.grey[200],
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => StoryScreen(story: stories[index]),
                          //     ),
                          //   );
                          // },
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: index == 0
                                        ? const CircleAvatar(
                                            radius: 40,
                                            child: Icon(Icons.add),
                                          )
                                        : CircleAvatar(
                                            radius: 40,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              "",
                                            ),
                                          ),
                                  ),
                                  // If this is the "Your Story" item, display the add icon
                                  // if (index == 0)
                                  //   Icon(Icons.add_circle, color: Colors.blue),
                                  if (index == 0) const Text("New"),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.black,
                    indicatorWeight: 1,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.grid_on),
                      ),
                      Tab(
                        icon: Image(
                          image: AssetImage("assets/image/reels.png"),
                          width: 23,
                          height: 23,
                        ),
                      ),
                      Tab(icon: Icon(Icons.person_pin_outlined)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

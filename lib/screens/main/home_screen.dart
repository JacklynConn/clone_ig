import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../constants/constant.dart';
import '../../controllers/home_controller.dart';
import '../../elements/user_element.dart';
import '../../widgets/story_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = Get.put(HomeController());

  String _getTimeSincePost(String createdAt) {
    DateTime postTime = DateTime.parse(createdAt);
    Duration timeDifference = DateTime.now().difference(postTime);

    if (timeDifference.inDays > 0) {
      return "${timeDifference.inDays} days ago";
    } else if (timeDifference.inHours > 0) {
      return "${timeDifference.inHours} hours ago";
    } else {
      return "${timeDifference.inMinutes} minutes ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: _homeController.posts.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0) _buildStory,
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      children: [
                        _homeController.posts[index].user!.profileUrl == null
                            ? Container(
                                margin: const EdgeInsets.all(5),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 33,
                                      height: 33,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            Colors.yellow,
                                            Colors.purple
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2)),
                                      child: Text(
                                        _homeController
                                            .posts[index].user!.name![0],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: baseUrlProfile +
                                    _homeController
                                        .posts[index].user!.profileUrl!,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 33,
                                          height: 33,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              colors: [
                                                Colors.yellow,
                                                Colors.purple
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[50],
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey[200],
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Text(_homeController.posts[index].user!.name!),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: baseUrlPost + _homeController.posts[index].photo!,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _homeController.likeDislike(
                              postId: _homeController.posts[index].id!);
                        },
                        icon: _homeController.posts[index].liked ?? false
                            ? const Icon(CupertinoIcons.heart_fill,
                                color: Colors.red)
                            : const Icon(
                                CupertinoIcons.heart,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          _homeController.showComments(
                              postId: _homeController.posts[index].id!);
                        },
                        icon: const Icon(CupertinoIcons.chat_bubble),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.paperplane),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.bookmark),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "${_homeController.posts[index].likes!.length} likes",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(_homeController.posts[index].caption ?? ""),
                  ),
                  GestureDetector(
                    onTap: () {
                      _homeController.showComments(
                          postId: _homeController.posts[index].id!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: _homeController.posts[index].comments!.isNotEmpty
                          ? Text(
                              "View all ${_homeController.posts[index].comments!.length} comments",
                              style: const TextStyle(color: Colors.grey),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Text(
                          _getTimeSincePost(
                              _homeController.posts[index].createdAt!),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      title: Row(
        children: [
          const Text(
            "Instagram",
            style: TextStyle(
                color: Colors.black, fontFamily: "instagram", fontSize: 45),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  CupertinoIcons.heart,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              // Only show the badge if there are liked posts
              if (_homeController.likedPostsCount > 0)
                Positioned(
                  right: 3,
                  top: 3,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                    child: Text(
                      '${_homeController.likedPostsCount}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.facebookMessenger,
            size: 23,
          ),
        ),
      ],
    );
  }

  Widget get _buildStory {
    return SizedBox(
      height: 120,
      // color: Colors.grey,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return StoryItemWidget(
            item: userList[index],
          );
        },
      ),
    );
  }
}

// child: _homeController.posts[index].comments!.length > 0
// ? Text(
// "View all ${_homeController.posts[index].comments!.length} comments",
// style: const TextStyle(color: Colors.grey),
// )
//     : const SizedBox.shrink(),

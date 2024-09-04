import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:flutter/material.dart';
import '../api/api.dart';
import '../constants/constant.dart';
import '../models/post_res_model.dart';

class HomeController extends GetxController {
  final _authService = NetworkService();
  PostResModel postResModel = PostResModel();
  var isLoading = true;

  @override
  onInit() {
    super.onInit();
    getAllPost();
  }

  List<Post> get posts => postResModel.data?.posts ?? [];

  void getAllPost() async {
    try {
      isLoading = true;
      final response = await _authService.getAllPost();
      postResModel = response;
      isLoading = false;
      update();
      print("Response : ${response}");
    } catch (e) {
      isLoading = false;
      print("Error ${e}");
    }
  }

  void likeDislike({required int postId}) async {
    try {
      final post = posts.firstWhere((post) => post.id == postId);
      post.liked = !post.liked!;
      final response = await _authService.likeDislike(postId: postId);
      update();
    } catch (e) {
      print("Error ${e}");
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: e.toString(),
      );
    }
  }

  int get likedPostsCount {
    return posts.where((post) => post.liked == true).length;
  }

  // void likeDislike({required int postId}) async {
  //   try {
  //     final post = posts.firstWhere((post) => post.id == postId);
  //     post.liked = !post.liked!;
  //   } catch (e) {
  //     print("Error ${e}");
  //   }
  // }

  Future<void> getPosts() async {
    try {
      isLoading = true;
      final response = await _authService.getAllPost();
      postResModel = response;
      isLoading = false;
      update();
      print("Response : $response");
    } catch (e) {
      isLoading = false;
      print("Error ${e}");
    }
  }

  void showComments({required int postId}) async {
    final response = await _authService.getCommentByPost(postId: postId);
    print("Response : $response");

    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                flex: 100,
                child: ListView.builder(
                  itemCount:
                      response.comments == null ? 0 : response.comments!.length,
                  itemBuilder: (context, index) {
                    final cmt = response.comments![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              cmt.user?.profileUrl != null
                                  ? CircleAvatar(
                                      radius: 11,
                                      backgroundImage: CachedNetworkImageProvider(
                                          "$baseUrlProfile${cmt.user?.profileUrl}"),
                                    )
                                  : CircleAvatar(
                                      radius: 11,
                                      child: Text(
                                        "${cmt.user?.name![0]}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                              const SizedBox(),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${cmt.user?.name}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    "${cmt.comment}",
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  const SizedBox(height: 5),
                                  InkWell(
                                    onTap: () {},
                                    child: const Text(
                                      "Reply",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Add a comment...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

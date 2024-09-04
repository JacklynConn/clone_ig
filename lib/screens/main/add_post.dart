import 'package:clone_ig/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/post_controller.dart';
import 'add_post_caption.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final PostController postController = Get.put(PostController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text(
          "New Post",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // Implement functionality here

              final data = await Get.to(() => AddPostCaption());
              if (data != null) {
                homeController.getAllPost();
              }
            },
            child: const Text(
              "Next",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<PostController>(builder: (_) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 400,
                child: postController.image != null
                    ? SingleChildScrollView(
                      child: Image.file(
                          postController.image!,
                          fit: BoxFit.cover,
                        ),
                    )
                    : const Icon(Icons.image, size: 120, color: Colors.grey),
              ),
              // SizedBox(
              //   height: 375,
              //   child: GridView.builder(
              //       // itemCount: _mediaList.length,
              //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 1,
              //         mainAxisSpacing: 1,
              //         crossAxisSpacing: 1,
              //       ),
              //       itemBuilder: (context, index) {
              //         // return _mediaList[index];
              //       }),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Recents",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                postController.selectPhoto();
                              },
                              icon: const Icon(Icons.upload),
                              label: const Text("Upload"),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        index = index;
                      });
                    },
                    child: Container(),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

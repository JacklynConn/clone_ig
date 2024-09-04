import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/post_controller.dart';

class AddPostCaption extends StatelessWidget {
  AddPostCaption({super.key});

  final PostController postController = Get.put(PostController());
  final TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: const Icon(Icons.close),
        // ),
        title: const Text(
          "New Post",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Implement functionality here
              if (postController.image == null) {
                Get.snackbar("Message", "Please select image");
                return;
              }
              postController.createPost(
                caption: _captionController.text,
                photo: postController.image!,
              );
            },
            child: const Text(
              "Post",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<PostController>(
        builder: (_) {
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
                      : const Icon(Icons.image),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _captionController,
                    decoration: const InputDecoration(
                      hintText: "Write a caption...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Tag People"),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text("Add Location"),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.emoji_emotions),
                  title: Text("Add Emoji"),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.timer),
                  title: Text("Set Timer"),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.check_box),
                  title: Text("Allow Sharing"),
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

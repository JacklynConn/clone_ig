
import 'package:flutter/material.dart';

import 'add_post.dart';
import 'add_reel.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

int currentIndex = 0;

class _PostScreenState extends State<PostScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      currentIndex = page;
    });
  }

  navigateToPage(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: const [
                AddPost(),
                AddReels(),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: 10,
              right: currentIndex == 0 ? 100 : 150,
              child: Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigateToPage(0);
                      },
                      child: Text(
                        "Post",
                        style: TextStyle(
                          color: currentIndex == 0 ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToPage(1);
                      },
                      child: Text(
                        "Reels",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: currentIndex == 1 ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

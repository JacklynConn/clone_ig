import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Text(
            "Instagram",
            style: TextStyle(
                color: Colors.black, fontFamily: "instagram", fontSize: 40),
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
          icon: const Icon(
            CupertinoIcons.heart,
            color: Colors.black,
            size: 25,
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
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/constant.dart';
import '../controllers/profile_controller.dart';
import '../models/profile/story_model.dart';

class StoryItemWidget extends StatelessWidget {
  final UserModel item;

  StoryItemWidget({super.key, required this.item});
  final _controllerProfile = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPicture,
        _buildTextName,
      ],
    );
  }

  Widget get _buildTextName {
    return SizedBox(
      width: 80,
      child: Text(
        item.name,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget get _buildPicture {
    return CachedNetworkImage(
      imageUrl: item.image,
      imageBuilder: (context, imageProvider) {
        return Container(
          margin: const EdgeInsets.all(5),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 86,
                height: 86,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Colors.yellow, Colors.purple],
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  border: Border.all(color: Colors.white, width: 2),
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
    );
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
}

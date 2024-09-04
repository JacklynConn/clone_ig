import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/constant.dart';
import '../models/comment_res_model.dart';
import '../models/post_res_model.dart';
import '../models/user_res_model.dart';
import 'dart:io';

class NetworkService {
  final box = GetStorage();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "$baseUrl/api",
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        "Accept": "application/json",
      },
    ),
  );

  Future<String> signup({
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
    required File? profileImage,
  }) async {
    try {
      final _formData = FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password_confirmation,
        "profile_image": await MultipartFile.fromFile(profileImage!.path),
      });
      final response = await dio.post("/register", data: _formData);
      if (response.statusCode == 200) {
        return "success";
      } else {
        return response.data['message'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserResModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post("/login", data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        return UserResModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> logout({required String token}) async {
    try {
      final response = await dio.post(
        "/logout",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserResModel> me() async {
    try {
      final token = box.read('access_token');
      final response = await dio.get("/me",
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));
      if (response.statusCode == 200) {
        return UserResModel.fromJson(response.data);
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // Create Post
  Future<bool> createPost(
      {required String caption, required File? photo}) async {
    try {
      final token = box.read('access_token');
      final _formData = FormData.fromMap({
        "caption": caption,
        "photo": await MultipartFile.fromFile(photo!.path),
      });
      final response = await dio.post(
        "/create",
        data: _formData,
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<PostResModel> getAllPost() async {
    try {
      final token = box.read('access_token');
      final response = await dio.get("/post",
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));
      if (response.statusCode == 200) {
        return PostResModel.fromJson(response.data);
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> likeDislike({required int postId}) async {
    try {
      final token = box.read('access_token');
      final response = await dio.post("/toggle-like/$postId",
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<CommentResModel> getCommentByPost({required int postId}) async {
    try {
      final token = box.read('access_token');
      final response = await dio.get("/comments/$postId",
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));
      if (response.statusCode == 200) {
        return CommentResModel.fromJson(response.data);
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

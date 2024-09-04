class CommentResModel {
  List<Comments>? comments;
  String? status;

  CommentResModel({this.comments, this.status});

  CommentResModel.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Comments {
  int? id;
  int? postId;
  int? userId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  User? user;

  Comments(
      {this.id,
        this.postId,
        this.userId,
        this.comment,
        this.createdAt,
        this.updatedAt,
        this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    userId = json['user_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['user_id'] = this.userId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? profileUrl;

  User({this.id, this.name, this.profileUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileUrl = json['profile_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_url'] = this.profileUrl;
    return data;
  }
}

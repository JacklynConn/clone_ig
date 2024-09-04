class PostResModel {
  final Data? data;
  final String? status;

  PostResModel({this.data, this.status});

  PostResModel.fromJson(Map<String, dynamic> json)
      : data = json['data'] != null ? Data.fromJson(json['data']) : null,
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'status': status,
      };
}

class Data {
  final int? currentPage;
  final List<Post>? posts;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Links>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  Data({
    this.currentPage,
    this.posts,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Data.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        posts = (json['data'] as List<dynamic>?)
            ?.map((item) => Post.fromJson(item as Map<String, dynamic>))
            .toList(),
        firstPageUrl = json['first_page_url'],
        from = json['from'],
        lastPage = json['last_page'],
        lastPageUrl = json['last_page_url'],
        links = (json['links'] as List<dynamic>?)
            ?.map((item) => Links.fromJson(item as Map<String, dynamic>))
            .toList(),
        nextPageUrl = json['next_page_url'],
        path = json['path'],
        perPage = json['per_page'],
        prevPageUrl = json['prev_page_url'],
        to = json['to'],
        total = json['total'];

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'data': posts?.map((post) => post.toJson()).toList(),
        'first_page_url': firstPageUrl,
        'from': from,
        'last_page': lastPage,
        'last_page_url': lastPageUrl,
        'links': links?.map((link) => link.toJson()).toList(),
        'next_page_url': nextPageUrl,
        'path': path,
        'per_page': perPage,
        'prev_page_url': prevPageUrl,
        'to': to,
        'total': total,
      };
}

class Post {
  final int? id;
  final String? caption;
  final String? photo;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final int? likesCount;
  final int? commentsCount;
   bool? liked;
  final User? user;
  final List<Likes>? likes;
  final List<Comments>? comments;

  Post({
    this.id,
    this.caption,
    this.photo,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.likesCount,
    this.commentsCount,
    this.liked,
    this.user,
    this.likes,
    this.comments,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        caption = json['caption'],
        photo = json['photo'],
        userId = json['user_id'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        likesCount = json['likes_count'],
        commentsCount = json['comments_count'],
        liked = json['liked'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        likes = (json['likes'] as List<dynamic>?)
            ?.map((item) => Likes.fromJson(item as Map<String, dynamic>))
            .toList(),
        comments = (json['comments'] as List<dynamic>?)
            ?.map((item) => Comments.fromJson(item as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'caption': caption,
        'photo': photo,
        'user_id': userId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'likes_count': likesCount,
        'comments_count': commentsCount,
        'liked': liked,
        'user': user?.toJson(),
        'likes': likes?.map((like) => like.toJson()).toList(),
        'comments': comments?.map((comment) => comment.toJson()).toList(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? profileUrl;
  final String? shortBio;
  final int? isActive;

  User({
    this.id,
    this.name,
    this.email,
    this.profileUrl,
    this.shortBio,
    this.isActive,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        profileUrl = json['profile_url'],
        shortBio = json['short_bio'],
        isActive = json['is_active'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'profile_url': profileUrl,
        'short_bio': shortBio,
        'is_active': isActive,
      };
}

class Likes {
  final int? id;
  final int? postId;
  final int? userId;

  Likes({this.id, this.postId, this.userId});

  Likes.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        postId = json['post_id'],
        userId = json['user_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'post_id': postId,
        'user_id': userId,
      };
}

class Comments {
  final int? id;
  final int? postId;
  final int? userId;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;

  Comments({
    this.id,
    this.postId,
    this.userId,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  Comments.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        postId = json['post_id'],
        userId = json['user_id'],
        comment = json['comment'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'post_id': postId,
        'user_id': userId,
        'comment': comment,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

class Links {
  final String? url;
  final String? label;
  final bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        label = json['label'],
        active = json['active'];

  Map<String, dynamic> toJson() => {
        'url': url,
        'label': label,
        'active': active,
      };
}
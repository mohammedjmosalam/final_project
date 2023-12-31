import 'package:final_project/data/model/comment.dart';

class PostModel {
  final String idUserPost;
  final List<String> images;
  final String contentPost;
  final List<String> whoLikes;
  final List<CommentModel> comments;
  final String idPost;
  final String datePost;
  final int idDate;
  PostModel({
    required this.comments,
    required this.contentPost,
    required this.idUserPost,
    required this.images,
    required this.whoLikes,
    required this.idPost,
    required this.datePost,
    required this.idDate,
  });
  PostModel copy({
    List<CommentModel>? comments,
    List<String>? whoLikes,
    String? contentPost,
  }) =>
      PostModel(
        comments: comments ?? this.comments,
        contentPost: contentPost ?? this.contentPost,
        datePost: datePost,
        idDate: idDate,
        idPost: idPost,
        idUserPost: idUserPost,
        images: images,
        whoLikes: whoLikes ?? this.whoLikes,
      );
  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        comments: List.from(json['comments'])
            .map((e) => CommentModel.fromJson(e))
            .toList(),
        contentPost: json['contentPost'],
        idUserPost: json['idUserPost'],
        images: List.from(json['images']),
        whoLikes: List.from(json['whoLikes']),
        idPost: json['idPost'],
        datePost: json['datePost'],
        idDate: json['idDate'],
      );
  Map<String, dynamic> get toJson => {
        'contentPost': contentPost,
        'idUserPost': idUserPost,
        'images': images,
        'whoLikes': whoLikes,
        'idPost': idPost,
        'idDate': idDate,
        'datePost': datePost,
        'comments': comments.map((e) => e.toJson).toList(),
      };
}

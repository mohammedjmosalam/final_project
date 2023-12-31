class CommentModel {
  final String commentContent;
  final String userId;
  CommentModel({
    required this.commentContent,
    required this.userId,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentContent: json['commentContent'],
        userId: json['userId'],
      );
  Map<String, dynamic> get toJson => {
        'commentContent': commentContent,
        'userId': userId,
      };
}

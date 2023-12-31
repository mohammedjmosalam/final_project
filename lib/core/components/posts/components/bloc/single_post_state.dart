part of 'single_post_cubit.dart';

class SinglePostState extends Equatable {
  const SinglePostState({
    this.userApp,
    this.isLikePost = false,
    required this.postData,
    required this.commentController,
    this.usersLikeAndComments = const {},
  });
  final UserApp? userApp;
  final bool isLikePost;
  final PostModel postData;
  final TextEditingController commentController;
  final Map<String, UserApp> usersLikeAndComments;

  SinglePostState copyWith({
    UserApp? userApp,
    bool? isLikePost,
    PostModel? postData,
    Map<String, UserApp>? usersLikeAndComments,
  }) =>
      SinglePostState(
        userApp: userApp ?? this.userApp,
        isLikePost: isLikePost ?? this.isLikePost,
        postData: postData ?? this.postData,
        commentController: commentController,
        usersLikeAndComments: usersLikeAndComments ?? this.usersLikeAndComments,
      );

  @override
  List<Object> get props => [
        isLikePost,
        postData,
        commentController,
        usersLikeAndComments,
      ];
}

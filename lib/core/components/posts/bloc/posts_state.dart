part of 'posts_cubit.dart';

class PostsState extends Equatable {
  const PostsState({
    this.navigatePost = NavigatePost.inti,
    this.posts = const [],
    this.getPostState = DialogsType.loading,
    this.errorMassage = '',
    this.postEdit,
  });
  final NavigatePost navigatePost;
  final List<PostModel> posts;
  final DialogsType getPostState;
  final String errorMassage;
  final PostModel? postEdit;
  PostsState copyWith({
    NavigatePost? navigatePost,
    List<PostModel>? posts,
    DialogsType? getPostState,
    String? errorMassage,
    PostModel? postEdit,
  }) =>
      PostsState(
        navigatePost: navigatePost ?? this.navigatePost,
        posts: posts ?? this.posts,
        errorMassage: errorMassage ?? this.errorMassage,
        getPostState: getPostState ?? this.getPostState,
        postEdit: postEdit ?? this.postEdit,
      );
  @override
  List<Object> get props => [navigatePost, posts, getPostState, errorMassage];
}

part of 'add_new_post_cubit.dart';

class AddNewPostState extends Equatable {
  const AddNewPostState({
    required this.postContent,
    this.dialogsType = DialogsType.init,
    this.images = const [],
    this.errorMassage = '',
    required this.isEditPost,
  });
  final TextEditingController postContent;
  final List<String> images;
  final DialogsType dialogsType;
  final String errorMassage;
  final bool isEditPost;
  AddNewPostState copyWith({
    TextEditingController? postContent,
    List<String>? images,
    DialogsType? dialogsType,
    String? errorMassage,
    bool? isEditPost,
  }) =>
      AddNewPostState(
        postContent: postContent ?? this.postContent,
        images: images ?? this.images,
        dialogsType: dialogsType ?? this.dialogsType,
        errorMassage: errorMassage ?? this.errorMassage,
        isEditPost: isEditPost ?? this.isEditPost,
      );
  @override
  List<Object> get props =>
      [postContent, images, dialogsType, errorMassage, isEditPost];
}

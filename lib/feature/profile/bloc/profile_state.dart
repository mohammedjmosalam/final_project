part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.isCurrentUserProfile,
    required this.userApp,
    this.dialogsType = DialogsType.init,
    this.errorMassage = '',
    required this.nameController,
    this.isShowEditName = false,
  });
  final bool isCurrentUserProfile;
  final UserApp userApp;
  final DialogsType dialogsType;
  final String errorMassage;
  final TextEditingController nameController;
  final bool isShowEditName;

  ProfileState copyWith(
          {bool? isCurrentUserProfile,
          UserApp? userApp,
          DialogsType? dialogsType,
          bool? isShowEditName,
          TextEditingController? nameController,
          String? errorMassage}) =>
      ProfileState(
        isCurrentUserProfile: isCurrentUserProfile ?? this.isCurrentUserProfile,
        userApp: userApp ?? this.userApp,
        dialogsType: dialogsType ?? this.dialogsType,
        errorMassage: errorMassage ?? this.errorMassage,
        nameController: nameController ?? this.nameController,
        isShowEditName: isShowEditName ?? this.isShowEditName,
      );

  @override
  List<Object> get props => [
        isCurrentUserProfile,
        userApp,
        dialogsType,
        errorMassage,
        nameController,
        isShowEditName,
      ];
}

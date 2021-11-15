part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

//=====get user data========
class SocialLoadingUserData extends SocialState {}

class SocialGetSuccessUserData extends SocialState {}

class SocialGetErrorUserData extends SocialState {
  final String error;
  SocialGetErrorUserData(this.error);
}

//=====get user data========
class SocialBottomNavBarChange extends SocialState {}

class SocialNewPostState extends SocialState {}

//=====profile image picker========
class SocialProfileImagePickedSuccessfully extends SocialState {}

class SocialErrorProfileImagePicked extends SocialState {}

//=====cover image picker========
class SocialCoverImagePickedSuccessfully extends SocialState {}

class SocialErrorCoverImagePicked extends SocialState {}

//=====upload profile picture to firestorage========
class SocialProfileImageUploadedSuccessfully extends SocialState {}

class SocialErrorProfilemageUploaded extends SocialState {}

//=====upload cover picture to firestorage========
class SocialCoverImageUploadedSuccessfully extends SocialState {}

class SocialErrorCoverImageUploaded extends SocialState {}

//=====upload user data========
class SocialLoadingUserDataUpload extends SocialState {}

class SocialUserDataUploadedError extends SocialState {}

//=====upload post picture to firestorage========
class SocialPostImageUploadedSuccessfully extends SocialState {}

class SocialErrorPostImageUploaded extends SocialState {}

//=====create post========
class SocialLoadingCreatePost extends SocialState {}

class SocialCreatePostError extends SocialState {}

class SocialCreatePostSuccess extends SocialState {}

//=====to remove post image when tap on close button========
class SocialRemovePostImage extends SocialState {}

//=====get post========
class SocialLoadingGetPosts extends SocialState {}

class SocialGetPostsError extends SocialState {}

class SocialGetPostsSuccess extends SocialState {}

//=====make like on post========
class SocialLikePostLoading extends SocialState {}

class SocialLikePostError extends SocialState {}

class SocialLikePostSuccess extends SocialState {}

//=====get all user data========
class SocialLoadingAllUserData extends SocialState {}

class SocialGetSuccessAllUserData extends SocialState {}

class SocialErrorGetAllUserData extends SocialState {
  final String error;
  SocialErrorGetAllUserData(this.error);
}
//=====log ouut========

class SocialLogoutSuccess extends SocialState {}

class SocialLogoutError extends SocialState {}

//=====send and get messages========
class SocialSendMessageSuccess extends SocialState {}

class SocialSendMessageError extends SocialState {}

class SocialGetMessageSuccess extends SocialState {}

class SocialGetMessageError extends SocialState {}

//=====for test========

class Test extends SocialState {}

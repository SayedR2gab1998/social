abstract class SocialStates{}

//initial states for social layout loading ,initial ,success ,and error
class SocialInitialState extends SocialStates{}
class SocialLoadingState extends SocialStates{}
class SocialSuccessState extends SocialStates{}
class SocialErrorState extends SocialStates{
  final String error;

  SocialErrorState(this.error);
}

//change bottom nav bar
class SocialChangeBottomNavState extends SocialStates{}
// create new post page state
class SocialNewPostState extends SocialStates{}

// pick profile image states success and error
class SocialProfileImagePickerSuccessState extends SocialStates{}
class SocialProfileImagePickerErrorState extends SocialStates{}

// pick cover image states loading ,success ,and error
class SocialCoverImagePickerSuccessState extends SocialStates{}
class SocialCoverImagePickerErrorState extends SocialStates{}
class SocialUpdateImagesLoadingState extends SocialStates{}

//upload profile image success and error
class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}

//upload cover image success and error
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}

//upload User date success and error
class SocialUpdateUserLoadingState extends SocialStates{}
class SocialUpdateUserErrorState extends SocialStates{}

// create new post Loading, success ,and error
class SocialCreateNewPostLoadingState extends SocialStates{}
class SocialCreateNewPostSuccessState extends SocialStates{}
class SocialCreateNewPostErrorState extends SocialStates{}

//upload cover image success and error
class SocialUploadPostImageSuccessState extends SocialStates{}
class SocialUploadPostImageLoadingState extends SocialStates{}
class SocialUploadPostImageErrorState extends SocialStates{}


//upload post image success and error
class SocialPostImagePickerSuccessState extends SocialStates{}
class SocialPostImagePickerErrorState extends SocialStates{}
class SocialRemovePostImageState extends SocialStates{}

// get post states loading, success, and error
class SocialGetPostLoadingState extends SocialStates{}
class SocialGetPostSuccessState extends SocialStates{}
class SocialGetPostErrorState extends SocialStates{
  final String error;

  SocialGetPostErrorState(this.error);
}

// post like states
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{
  final String error;

  SocialLikePostErrorState(this.error);
}

//get users states Loading, success, and error
class SocialGetUsersLoadingState extends SocialStates{}
class SocialGetUsersSuccessState extends SocialStates{}
class SocialGetUsersErrorState extends SocialStates{
  final String error;

  SocialGetUsersErrorState(this.error);
}


// chat states send and get
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessageSuccessState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{}
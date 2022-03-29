import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/component/constant.dart';
import 'package:social/layout/cubit/social_states.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/post_model.dart';
import 'package:social/models/social_model.dart';
import 'package:social/modules/new_post/new_post_screen.dart';
import 'package:social/modules/setting/setting_screen.dart';
import 'package:social/modules/social_chat/chat_screen.dart';
import 'package:social/modules/social_feed/feed_screen.dart';
import 'package:social/modules/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit(): super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUsersData(){
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
          //print(value.data());
          userModel= SocialUserModel.fromJson(value.data()!);
          emit(SocialSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(SocialErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> bottomsScreens = [
    const FeedScreen(),
    const ChatScreen(),
    AddPost(),
    const UsersScreen(),
    const SettingScreen(),
  ];
  List<String> titles =
  [
    'News Feed',
    'Chats',
    '',
    'Users',
    'Settings',
  ];

  void changeBottomNav(index) {
    if(index == 1) {
      getUsers();
    }
    if(index == 2) {
      emit(SocialNewPostState());
    } else
    {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage ()async
  {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage !=null)
      {
        profileImage = File(pickedImage.path);
        emit(SocialProfileImagePickerSuccessState());
      }
    else
    {
      emit(SocialProfileImagePickerErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage ()async
  {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage !=null)
    {
      coverImage = File(pickedImage.path);
      emit(SocialCoverImagePickerSuccessState());
    }
    else
    {
      emit(SocialCoverImagePickerErrorState());
    }
  }

  //upload profile image

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
})
  {
    emit(SocialUpdateImagesLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL()
              .then((value) {
            updateUser(
              name: name,
              bio: bio,
              phone: phone,
              profile: value
            );
          })
              .catchError((error){
                emit(SocialUploadProfileImageErrorState());
          });
    })
        .catchError((error){
      emit(SocialUploadProfileImageErrorState());
    });
  }



  //upload cover image

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  })
  {
    emit(SocialUpdateImagesLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        updateUser(
            name: name,
            bio: bio,
            phone: phone,
            cover: value
        );
      })
          .catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }

  //update user date
  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? profile,
})
  {
    emit(SocialUpdateUserLoadingState());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      coverImage: cover ?? userModel!.coverImage,
      profileImage: profile ?? userModel!.profileImage,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUsersData();
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }

  //get post Image
  File? postImage;

  Future<void> getPostImage ()async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage !=null)
    {
      postImage = File(pickedImage.path);
      emit(SocialPostImagePickerSuccessState());
    }
    else
    {
      emit(SocialPostImagePickerErrorState());
    }
  }
  void removePostImage () {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  //upload post Image
  void uploadPostImage({
    required String text,
    required String dateTime,
  })
  {
    emit(SocialUploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
            createNewPost(
              text: text,
              dateTime: dateTime,
              postImage: value,
            );
      })
          .catchError((error){
        emit(SocialUploadPostImageErrorState());
      });
    })
        .catchError((error){
      emit(SocialUploadPostImageErrorState());
    });
  }

  //create post
  void createNewPost({
    required String text,
    required String dateTime,
    String? postImage,
  })
  {
    emit(SocialCreateNewPostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      profileImage: userModel!.profileImage,
      uId: userModel!.uId,
      postText: text,
      dateTime: dateTime,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(SocialCreateNewPostSuccessState());
    }).catchError((error) {
      emit(SocialCreateNewPostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> like =[];

  void getPosts()
  {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          for (var element in value.docs) {
            element.reference.collection('likes').get().then((value){
              like.add(value.docs.length);
              posts.add(PostModel.fromJson(element.data()));
              postId.add(element.id);
              emit(SocialGetPostSuccessState());
            }).catchError((error){});

          }
    })
        .catchError((error){
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users =[];
  void getUsers()
  {
    users=[];
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      for (var element in value.docs) {
        if(element.data()['uId'] != userModel!.uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
        emit(SocialGetUsersSuccessState());
      }
    })
        .catchError((error){
      emit(SocialGetUsersErrorState(error.toString()));
    });
  }

  void sendMessage({
  required String? receiverId,
  required String? messageText,
  required String? dateTime,
})
  {
    MessageModel model = MessageModel(
      dateTime: dateTime,
      senderId: userModel!.uId,
      receiverId: receiverId,
      messageText: messageText
    );

    //send my chats
    FirebaseFirestore.instance
    .collection('users').
    doc(userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value) {
      emit(SocialSendMessageSuccessState());
    })
    .catchError((error){
      emit(SocialSendMessageErrorState());
    });

    //send receiver chats
    FirebaseFirestore.instance
      .collection('users').
      doc(receiverId)
      .collection('chats')
      .doc(userModel!.uId)
      .collection('messages')
      .add(model.toMap())
      .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages =[];
  void getMessage({
    required String? receiverId,
})
  {

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          for (var element in event.docs) {
            messages.add(MessageModel.fromJson(element.data()));
          }});
    emit(SocialGetMessageSuccessState());
  }
}
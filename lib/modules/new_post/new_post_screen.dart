import 'package:flutter/material.dart';
import 'package:social/component/component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/component/constant.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_states.dart';
import 'package:social/shared/style/icon_broken.dart';

class AddPost extends StatelessWidget {
   AddPost({Key? key}) : super(key: key);
   var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){
        if(state is SocialCreateNewPostSuccessState)
          {
            showToast(
              message: 'Post Created',
              state: ToastStates.SUCCESS
            );
          }
        if(state is SocialUploadPostImageSuccessState)
        {
          showToast(
              message: 'Post Created',
              state: ToastStates.SUCCESS
          );
        }
      },
      builder: (context, state)
      {
        var model = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: DefaultAppBar(
            title: 'Create Post',
            action: [
              defaultTextButton(
                  function: (){
                    if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).createNewPost(
                          text: textController.text,
                          dateTime: DateTime.now().toString(),
                      );

                    }
                    else
                    {
                      SocialCubit.get(context).uploadPostImage(
                        text: textController.text,
                        dateTime: DateTime.now().toString(),
                      );
                    }
                  },
                  text: 'Post'
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children:
              [
                if(state is SocialCreateNewPostLoadingState)
                  const LinearProgressIndicator(),
                if(state is SocialCreateNewPostLoadingState)
                  const SizedBox(height: 10.0,),
                Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${model!.profileImage}'),

                    ),
                    const SizedBox(width: 15.0,),
                    Text('${model.name}')
                  ],
                ),
                const SizedBox(height: 20.0,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'what is in your mind....',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 240,
                        decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              image:FileImage(SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: defaultColor,
                        child: IconButton(
                          onPressed: (){SocialCubit.get(context).removePostImage();},
                          icon: const Icon(IconBroken.Close_Square),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                if(SocialCubit.get(context).postImage != null)
                  const SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const
                          [
                             Icon(IconBroken.Image),
                              SizedBox(width: 5.0,),
                             Text('add photo')
                          ],
                        )
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: const Text('#tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

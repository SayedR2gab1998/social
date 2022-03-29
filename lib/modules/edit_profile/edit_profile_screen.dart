import 'package:flutter/material.dart';
import 'package:social/component/component.dart';
import 'package:social/component/constant.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/style/icon_broken.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();


  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon:const Icon(IconBroken.Arrow___Left_2),
              onPressed: (){Navigator.pop(context);},
            ),
            titleSpacing: 5.0,
            title: const Text('Edit Profile'),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 15.0),
                child: defaultTextButton(
                  function: (){
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                    );
                  },
                  text: 'update'
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUpdateUserLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SocialUpdateUserLoadingState)
                    const SizedBox(height: 10.0,),
                  SizedBox(
                    height: 290,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
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
                                      image: coverImage==null? NetworkImage('${userModel.coverImage}'):FileImage(coverImage) as ImageProvider,
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
                                  onPressed: (){SocialCubit.get(context).getCoverImage();},
                                  icon: const Icon(IconBroken.Camera),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child:  CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null ? NetworkImage('${userModel.profileImage}',) : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: defaultColor,
                                child: IconButton(
                                  onPressed: (){
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: const Icon(IconBroken.Camera),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  // if(SocialCubit.get(context).profileImage !=null ||SocialCubit.get(context).coverImage !=null)
                  //   Row(
                  //   children:
                  //   [
                  //     if(SocialCubit.get(context).profileImage !=null)
                  //       Column(
                  //         children: [
                  //           Expanded(
                  //           child: defaultButton(
                  //             text: 'upload profile',
                  //             onPressed: (){
                  //               SocialCubit.get(context).uploadProfileImage(
                  //                 name: nameController.text,
                  //                 bio: bioController.text,
                  //                 phone: phoneController.text
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //           if(state is SocialUpdateImagesLoadingState)
                  //             const SizedBox(height: 5.0,),
                  //           if(state is SocialUpdateImagesLoadingState)
                  //             const LinearProgressIndicator(),
                  //         ],
                  //       ),
                  //     const SizedBox(width: 5.0,),
                  //     if(SocialCubit.get(context).coverImage !=null)
                  //       Column(
                  //         children: [
                  //           Expanded(
                  //           child: defaultButton(
                  //             text: 'upload cover',
                  //             onPressed: (){
                  //               SocialCubit.get(context).uploadCoverImage(
                  //                   name: nameController.text,
                  //                   bio: bioController.text,
                  //                   phone: phoneController.text
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //           if(state is SocialUpdateImagesLoadingState)
                  //             const SizedBox(height: 5.0,),
                  //           if(state is SocialUpdateImagesLoadingState)
                  //             const LinearProgressIndicator(),
                  //         ],
                  //       ),
                  //   ],
                  // ),
                  // if(SocialCubit.get(context).profileImage !=null ||SocialCubit.get(context).coverImage !=null)
                  //   const SizedBox(height: 20.0,),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload profile',
                                ),
                                if (state is SocialUpdateImagesLoadingState)
                                  const SizedBox(height: 5.0,),
                                if (state is SocialUpdateImagesLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(width: 5.0,),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload cover',
                                ),
                                if (state is SocialUpdateImagesLoadingState)
                                  const SizedBox(height: 5.0,),
                                if (state is SocialUpdateImagesLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(height: 20.0,),
                  defaultTextFormField(
                    controller: nameController,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                        {
                          return 'Name must be not empty';
                        }
                      return null;
                    },
                    inputType: TextInputType.name,
                    label: 'Name',
                    prefix: IconBroken.User
                  ),
                  const SizedBox(height: 10.0,),
                  defaultTextFormField(
                    controller: bioController,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'Bio must be not empty';
                      }
                      return null;
                    },
                    inputType: TextInputType.text,
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle
                  ),
                  const SizedBox(height: 10.0,),
                  defaultTextFormField(
                    controller: phoneController,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'Phone must be not empty';
                      }
                      return null;
                    },
                    inputType: TextInputType.phone,
                    label: 'Phone',
                    prefix: IconBroken.Call
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

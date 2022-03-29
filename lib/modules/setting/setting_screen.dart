import 'package:flutter/material.dart';
import 'package:social/component/component.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/edit_profile/edit_profile_screen.dart';
import 'package:social/shared/style/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state)  {},
      builder: (context, state)  {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:
            [
              SizedBox(
                height: 290,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
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
                              image: NetworkImage('${userModel!.coverImage}'),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child:  CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage('${userModel.profileImage}'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0,),
              Text('${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text('${userModel.bio}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children:
                  [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children:
                          [
                            Text('100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text('Post',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children:
                          [
                            Text('100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text('Post',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children:
                          [
                            Text('100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text('Post',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children:
                          [
                            Text('100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text('Post',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        'Add Photos',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  OutlinedButton(
                    onPressed: () {navigateTo(context, EditProfileScreen());},
                    child: const Icon(
                      IconBroken.Edit,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

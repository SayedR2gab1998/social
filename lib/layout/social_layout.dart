import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/component/component.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_states.dart';
import 'package:social/modules/new_post/new_post_screen.dart';
import 'package:social/shared/style/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){
        if(state is SocialNewPostState)
          {
            navigateTo(context,  AddPost());
          }
      },
      builder: (context, state){
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: (){},
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(IconBroken.Search),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              // change the screen from cubit
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Upload), label: 'Post'),
              BottomNavigationBarItem(icon: Icon(IconBroken.User1), label: 'Users'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
          ),
          body: cubit.bottomsScreens[cubit.currentIndex],
        );
      },
    );
  }
}

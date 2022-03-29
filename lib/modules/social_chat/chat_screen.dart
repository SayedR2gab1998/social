import 'package:flutter/material.dart';
import 'package:social/component/component.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_states.dart';
import 'package:social/models/social_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:social/modules/social_chat_details/social_chat_details.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context ,state){},
      builder: (context, state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context)=>ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildUserItem(SocialCubit.get(context).users[index],context),
            itemCount: SocialCubit.get(context).users.length,
            separatorBuilder: (context,index)=>const Divider(color: Colors.grey,),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
  Widget buildUserItem(SocialUserModel model,BuildContext context){
    return InkWell(
      onTap: (){
        navigateTo(context, ChatDetailsScreen(
          model: model,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 15.0),
        child: Row(
          children:
          [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('${model.profileImage}'),
            ),
            const SizedBox(width: 15,),
            Text('${model.name}',
              style: const TextStyle(
                height: 1.4,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:social/component/constant.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_states.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/social_model.dart';
import 'package:social/shared/style/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ChatDetailsScreen extends StatelessWidget {
   ChatDetailsScreen({Key? key, this.model}) : super(key: key);
  SocialUserModel? model;
  var messageController = TextEditingController();
  var scrollController = ScrollController();

   @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(receiverId: model!.uId);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state){},
          builder: (context, state)
          {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(IconBroken.Arrow___Left_2),
                  onPressed: ()
                  {
                    Navigator.pop(context);
                  },
                ),
                titleSpacing: 0.0,
                title: Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${model!.profileImage}'),
                    ),
                    const SizedBox(width: 10.0,),
                    Text('${model!.name}'),
                  ],
                ),
              ),
              body: Padding(
                padding:const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                child: Column(
                  children:
                  [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: SocialCubit.get(context).messages.isNotEmpty,
                        builder:(context) => Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              reverse: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context,  index)
                              {
                                var messages =SocialCubit.get(context).messages[index];
                                if(SocialCubit.get(context).userModel!.uId == messages.senderId) {
                                  return buildMyChat(messages);
                                }
                                return buildReceiverChat(messages);
                              },
                              itemCount: SocialCubit.get(context).messages.length,
                            )
                        ),
                        fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                      ),
                    ),
                    const SizedBox(height: 15.0,),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!,width: 1.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children:
                        [
                          const Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(IconBroken.Message),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                controller: messageController,
                                onFieldSubmitted: (s)
                                {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: model!.uId,
                                    messageText: messageController.text,
                                    dateTime: DateTime.now().toString(),
                                  );
                                  messageController.clear();
                                  scrollController.animateTo(
                                    0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeIn,
                                  );
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Type your message...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: defaultColor,
                            child: MaterialButton(
                              minWidth: 1.0,
                              onPressed: (){
                                SocialCubit.get(context).sendMessage(
                                  receiverId: model!.uId,
                                  messageText: messageController.text,
                                  dateTime: DateTime.now().toString(),
                                );
                                messageController.clear();
                                scrollController.animateTo(
                                  0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: const Icon(IconBroken.Send,color: Colors.white,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
  Widget buildMyChat(MessageModel model){
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 10.0),
        child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.2),
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                bottomEnd: Radius.circular(10.0),
              ),
            ),
            child:  Padding(
              padding:const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
              child: Text('${model.messageText}'),
            )
        ),
      ),
    );
  }
  Widget buildReceiverChat(MessageModel model){
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 10.0),
        child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0),
              ),
            ),
            child:  Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
              child: Text('${model.messageText}'),
            )
        ),
      ),
    );
  }
}
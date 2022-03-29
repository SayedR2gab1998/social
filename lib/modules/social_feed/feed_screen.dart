import 'package:flutter/material.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_states.dart';
import 'package:social/models/post_model.dart';
import 'package:social/shared/style/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModel != null,
          builder: (BuildContext context) =>SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children:
              [
                Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.all(8.0),
                    elevation: 5.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const Image(
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                          image: NetworkImage('https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Communicate with friends',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.white,
                                fontSize: 16.0
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index,),
                    separatorBuilder: (context,index)=>const SizedBox(height: 4.0,),
                    itemCount: SocialCubit.get(context).posts.length
                ),
              ],
            ),
          ),
          fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildPostItem(PostModel model, BuildContext context,index){
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children:
              [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage('${model.profileImage}'),
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                       Text('${model.name}',
                        style: const TextStyle(
                          height: 1.4,
                        ),
                      ),
                      Text('${model.dateTime}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(IconBroken.More_Circle)
                ),
              ],
            ),
            const Divider(color: Colors.grey,),
            Text('${model.postText}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            if(model.postImage !='')
              Padding(
              padding: const EdgeInsetsDirectional.only(top: 10.0),
              child: Container(
                height: 160.0,
                width: double.infinity,
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image:  DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(IconBroken.Heart,color: Colors.red,size: 18,),
                          const SizedBox(width: 5.0,),
                          Text('${SocialCubit.get(context).like[index]}'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const[
                          Icon(IconBroken.Chat,color: Colors.red,size: 18,),
                          SizedBox(width: 5.0,),
                          Text('0 comment'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey,),
            Row(
              children:
              [
                Expanded(
                  child: Row(
                    children:
                    [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.profileImage}'),
                      ),
                      const SizedBox(width: 10.0,),
                      Text('write a comment ...',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                    onTap: (){
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                    },
                    child: Row(
                      children: [
                        const Icon(IconBroken.Heart,size: 18,color: Colors.red,),
                        Text('Like',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

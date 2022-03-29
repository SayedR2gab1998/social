import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social/component/component.dart';
import 'package:social/component/constant.dart';
import 'package:social/firebase_options.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/social_layout.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/shared/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/style/themes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());

  showToast(message: 'on background message', state: ToastStates.SUCCESS,);
}
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  var token = await FirebaseMessaging.instance.getToken();

  print("==============================token=======================");
  print(token);


  // foreground fcm
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
    showToast(message: 'on message', state: ToastStates.SUCCESS);
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
    showToast(message: 'on message opened app', state: ToastStates.SUCCESS);
  });
  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init(

  );
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if(uId != null)
  {
    widget = const SocialLayout();
  }
  else
    {
      widget =  LoginScreen();
    }
  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=> SocialCubit()..getUsersData()..getPosts()..getUsers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
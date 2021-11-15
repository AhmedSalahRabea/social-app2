// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app_modules/login/social_login_screen.dart';
import 'package:social_app/shared/bloc_bserver/bloc_observer.dart';
import 'package:social_app/shared/components/constans.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/doi_helper.dart';
import 'package:social_app/shared/styles/theme.dart';
import 'package:social_app/social_layout/cubit/social_cubit.dart';
import 'package:social_app/social_layout/social_layout.dart';

import 'modules/shop_modules/on_boarding/cubit/onboarding_cubit.dart';

//الدالة دي عشان أهندل الاشعارات اللي بتيجي ف الخلفية وبتكون فوق ملف الmain
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('======== notification when app in background or terminated');
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //this token just for notification
  //كل جهاو بياخد توكن خاص بيه عشان ابعت عليه الاشعار
  //فاانا كده بحدد التوكن بتاع الجهاز اللي هيشتغل عليه البرنامج
  var token = await FirebaseMessaging.instance.getToken();
  print('======== $token');

  //الدالة دي بتساعدني عند استقبال الاشعار والتطبيق مفتوح
  FirebaseMessaging.onMessage.listen((event) {
    print('======== notification when app in foreground');
    print(event.data.toString());
    print(event.notification!.body.toString());
  });
//الدالة دي بتساعدني علي استقبال الاشعار والتطبيق مفتوح بس في الخلفية
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('======== notification when app in background');
    print(event.data.toString());
  });

  //هنا هستخدم الدالة اللي عملتها فوق عشان أهندل الاشعارات لو التطبيق مقفول او في الخلفية
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget startWidget;
  bool? isDark = CacheHelper.getDataFromSharedPrefrences(key: 'isDark');
  uId = CacheHelper.getDataFromSharedPrefrences(key: 'uId');
  if (uId != null) {
    startWidget = SocialLayout();
  } else {
    startWidget = SocialLoginScreen();
  }

  runApp(
    MyApp(
      isDark: isDark,
      startWidget: startWidget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  MyApp({required this.startWidget, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
        BlocProvider(create: (context) => OnboardingCubit()),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: MyTheme.myLightThemeMode,
            darkTheme: MyTheme.myDarkThemeMode,
            themeMode: cubit.isDark ? ThemeMode.light : ThemeMode.dark,
            home: startWidget,
          );
        },
      ),
    );
  }
}

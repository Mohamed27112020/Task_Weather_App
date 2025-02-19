import 'package:chat_1_app/Cubit/LoginCubit/login_cubit.dart';
import 'package:chat_1_app/Cubit/RegisterCubit/register_cubit.dart';
import 'package:chat_1_app/Cubit/cubit/chat_cubit.dart';
import 'package:chat_1_app/Pages/Thome.dart';
import 'package:chat_1_app/testchatbubble.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/Home.dart';
import 'Pages/Login_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCFJKrIBaNmq1EXu1l53AJv6JWa-5Jp8Ac',
    messagingSenderId: '255980536990',
    projectId: 'chat1app-a6c6a',
    appId: '1:255980536990:android:8ed80e89eaa3e320e9e78f',
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
            BlocProvider(
          create: (context) => LoginCubit(),
        ),
            BlocProvider(
                create: (context) => RegisterCubit(),
            ),
            BlocProvider(
                create: (context) => ChatCubit(),
            ),
        ],
              child: MaterialApp(
            title: 'Chat app',
            home: Login_Page(),
          ),
    );
  }
}

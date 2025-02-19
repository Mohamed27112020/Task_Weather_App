import 'dart:async';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat_1_app/Component/Custombutton.dart';
import 'package:chat_1_app/Component/Shaed.dart';
import 'package:chat_1_app/Component/customtextfiled.dart';
import 'package:chat_1_app/Cubit/LoginCubit/login_cubit.dart';
import 'package:chat_1_app/Cubit/RegisterCubit/register_cubit.dart';
import 'package:chat_1_app/Pages/Home.dart';
import 'package:chat_1_app/Pages/Register_Screen.dart';
import 'package:chat_1_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Component/Constant.dart';
import '../Cubit/LoginCubit/login_state.dart';

class Login_Page extends StatelessWidget {
  Login_Page({super.key});

  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String? email;
  String? userName;
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  String? password;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCMessages);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          const Center(child: CircularProgressIndicator());

          showSnackbar(context, 'Loading login', Colors.grey);
        } else if (state is LoginSucces) {
          showSnackbar(context, 'Sucsses login', Colors.green);
        
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomePage(
              email: email!,
            );
          }));
        } else if (state is LoginFailure) {
          showSnackbar(context, 'failure login ', Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Kprimarycolor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      width: 120,
                      height: 120,
                      scale: 1,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customTextField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      hinttext: 'Email',
                      onchange: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customTextField(
                      controller: passwordcontroller,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      hinttext: 'Password',
                      onchange: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    custombutton(
                      namebutton: 'Login',
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          await BlocProvider.of<LoginCubit>(context).loginfun(
                              email: email!,
                              password: password!,
                              context: state);
                        }
                        passwordcontroller.clear();
                        emailcontroller.clear();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account ? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: ((context) {
                                return RegisterPage();
                              }),
                            ));
                          },
                          child: const Text(
                            "Register ",
                            style: TextStyle(color: Colors.greenAccent),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

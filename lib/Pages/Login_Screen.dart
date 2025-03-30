import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_weather_app/Component/Custombutton.dart';
import 'package:task_weather_app/Component/Shaed.dart';
import 'package:task_weather_app/Component/customtextfiled.dart';
import 'package:task_weather_app/Cubit/LoginCubit/login_cubit.dart';
import 'package:task_weather_app/pages/Register_Screen.dart';
import 'package:task_weather_app/pages/home_page.dart';

import '../Component/Constant.dart';
import '../Cubit/LoginCubit/login_state.dart';

class Login_Page extends StatelessWidget {
  Login_Page({super.key});

  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          const Center(child: CircularProgressIndicator());

          showSnackbar(context, 'Loading login', Colors.grey);
        } else if (state is LoginSucces) {
          showSnackbar(context, 'Sucsses login', Colors.green);

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        } else if (state is LoginFailure) {
          showSnackbar(context, 'failure login ', Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Kprimarycolor,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                    const SizedBox(height: 50),
                    customTextField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      hinttext: 'Email',
                      onchange: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(height: 10),
                    customTextField(
                      controller: passwordcontroller,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      hinttext: 'Password',
                      onchange: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(height: 30),
                    custombutton(
                      namebutton: 'Login',
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          await BlocProvider.of<LoginCubit>(
                            context,
                          ).loginfun(email: email!, password: password!);
                        }
                        passwordcontroller.clear();
                        emailcontroller.clear();
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account ? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) {
                                  return RegisterPage();
                                }),
                              ),
                            );
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

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat_1_app/Cubit/RegisterCubit/register_cubit.dart';
import 'package:chat_1_app/Cubit/RegisterCubit/register_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Component/Constant.dart';
import '../Component/Custombutton.dart';
import '../Component/Shaed.dart';
import '../Component/customtextfiled.dart';
import 'Home.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String? name;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterLoading) {
          showSnackbar(context, 'Loading Register', Colors.grey);
        } else if (state is RegisterSucces) {
          showSnackbar(context, 'Success Register', Colors.green);
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomePage(
              email: email!,
            );
          }));
        } else if (state is RegisterFailure) {
          showSnackbar(context, 'Failure Register', Colors.red);
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
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      width: 120,
                      height: 120,
                      scale: 1,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Register ',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    customTextField(
                      controller: namecontroller,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      hinttext: 'Name',
                      onchange: (data) {
                        name = data;
                      },
                    ),
                    SizedBox(
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
                    SizedBox(
                      height: 10,
                    ),
                    customTextField(
                      controller: passwordcontroller,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      hinttext: 'password',
                      onchange: (data) {
                        password = data;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    custombutton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          await BlocProvider.of<RegisterCubit>(context)
                              .Registerfun(
                                  email: email!,
                                  password: password!,
                                  name: name!,
                                  context: context);
                          await user.add({
                            'email': email,
                            'name': name!,
                            'password':password!,
                          });
                        }
                        namecontroller.clear();
                        emailcontroller.clear();
                        passwordcontroller.clear();
                      },
                      namebutton: 'Register',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account ? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login ",
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

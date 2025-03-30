import 'package:bloc/bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_weather_app/Cubit/RegisterCubit/register_state.dart';


import '../../Component/Shaed.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
 
  Future<void> Registerfun(
      {context,
      required String email,
      required String password,}) async {
    emit(RegisterLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSucces());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackbar(context, 'The account already exists for that email.',
            Colors.yellow);
        print('The account already exists for that email.');
      }
    } catch (e) {
      emit(RegisterFailure());
      print(e.toString());
    }
  }
}

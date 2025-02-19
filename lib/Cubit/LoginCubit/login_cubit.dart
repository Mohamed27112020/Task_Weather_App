import 'package:bloc/bloc.dart';
import 'package:chat_1_app/Cubit/LoginCubit/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../Component/Shaed.dart';
import '../../Pages/Home.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  String? uid ;
  Future<void> loginfun(
      {context, required String email, required String password}) async {
    emit(LoginInitial());

    try {
      emit(LoginLoading());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      uid = credential.user!.uid;
    //  print(credential.user!.uid);
      emit(LoginSucces());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (e) {
      emit(LoginFailure());
      print(e.toString());
    }
  }
}

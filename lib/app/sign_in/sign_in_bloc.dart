import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInBloc {
  SignInBloc({required this.auth, required this.isLoading});

  final AuthBase auth;
  final ValueNotifier<bool> isLoading;
  //
  // final StreamController<bool> _isLoadingController = StreamController<bool>();
  //
  // Stream<bool> get isLoadingStream => _isLoadingController.stream;
  //
  // void dispose() {
  //   _isLoadingController.close();
  // }
  // void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnonymously() async => await _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

  Future<User> signInWithFacebook() async => await _signIn(auth.signInWithFacebook);
}

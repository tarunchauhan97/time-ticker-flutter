import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';


class SignInBloc {
  SignInBloc({required this.auth});

  final AuthBase auth;

  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      rethrow;
    } finally {
      _setIsLoading(false);
    }
  }

  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

  Future<User> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);

// Future<User> signInAnonymously() async {
//   try {
//     setIsLoading(true);
//     return await auth.signInAnonymously();
//   } catch (e) {
//     rethrow;
//   } finally {
//     setIsLoading(false);
//   }
// }
//
// Future<User> signInWithGoogle() async {
//   try {
//     setIsLoading(true);
//     return await auth.signInWithGoogle();
//   } catch (e) {
//     rethrow;
//   } finally {
//     setIsLoading(false);
//   }
// }
//
// Future<User> signInWithFacebook() async {
//   try {
//     setIsLoading(true);
//     return await auth.signInWithFacebook();
//   } catch (e) {
//     rethrow;
//   } finally {
//     setIsLoading(false);
//   }
// }
}

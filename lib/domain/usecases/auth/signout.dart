import 'package:dartz/dartz.dart';
import 'package:spotify_clone/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_clone/service_locator.dart';

abstract class SignOutUseCase {
  Future<Either> call();
}

class SignOutUseCaseImpl extends SignOutUseCase {
  @override
  Future<Either> call() async {
    return await sl<AuthFirebaseService>().signOut();
  }
}
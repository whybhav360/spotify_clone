import 'package:dartz/dartz.dart';
import 'package:spotify_clone/data/sources/auth/auth_firebase_service.dart';

import '../../../domain/repository/auth/auth.dart';
import '../../../service_locator.dart';
import '../../models/auth/create_user_req.dart';
import '../../models/auth/signin_user_request.dart';

class AuthRepositoryImpl extends AuthRepository {


  @override
  Future<Either> signin(SigninUserRequest signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }

  @override
  Future<Either> signOut() async {
    return await sl<AuthFirebaseService>().signOut();
  }

}
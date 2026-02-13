import 'package:dartz/dartz.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';

import '../../../data/models/auth/signin_user_request.dart';

abstract class AuthRepository {

  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SigninUserRequest signInUserRequest);

  Future<Either> getUser();

}

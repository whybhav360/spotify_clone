import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/data/models/auth/signin_user_request.dart';

import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SigninUseCase implements UseCase<Either, SigninUserRequest> {
  @override
  Future<Either<dynamic, dynamic>> call({SigninUserRequest? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
}

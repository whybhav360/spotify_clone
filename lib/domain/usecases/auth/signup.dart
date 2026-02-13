import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';

import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SignupUseCase implements UseCase<Either,CreateUserReq> {
  @override
  Future<Either<dynamic, dynamic>> call({CreateUserReq ? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
  
}
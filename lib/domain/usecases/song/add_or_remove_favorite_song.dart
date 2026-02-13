import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../../repository/song/song.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  @override
  Future<Either<dynamic, dynamic>> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
}

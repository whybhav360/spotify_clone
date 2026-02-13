import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_new_songs.dart';

import '../../../service_locator.dart';
import 'new_songs_state.dart';

class NewSongsCubit extends Cubit<NewSongsState> {
  NewSongsCubit() : super(NewSongsLoading());

  Future<void> getNewSongs() async {
    var returnedSongs = await sl<GetNewSongsUseCase>().call();
    returnedSongs.fold(
      (l) {
        emit(NewSongsLoadFailure(l));
      },
      (data) {
        emit(
            NewSongsLoaded(songs:data)
        );
      },
    );
  }
}

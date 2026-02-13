import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/domain/entities/song/song.dart';
import 'package:spotify_clone/presentation/home/bloc/new_songs_cubit.dart';
import 'package:spotify_clone/presentation/song_player/pages/song_player.dart';

import '../bloc/new_songs_state.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewSongsCubit()..getNewSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewSongsCubit, NewSongsState>(
          builder: (context, state) {
            if (state is NewSongsLoading) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
            if (state is NewSongsLoaded) {
              if (state.songs.isEmpty) {
                return const Center(child: Text('No Songs Found'));
              }
              return _songs(state.songs);
            }
            if (state is NewSongsLoadFailure) {
              return Text(state.message);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      SongPlayerPage(songEntity: songs[index]),
                ),
              );
            },
            child: SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(songs[index].coverURL),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          transform: Matrix4.translationValues(10, 10, 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode
                                ? AppColors.darkGrey
                                : Colors.white,
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            color: context.isDarkMode
                                ? Colors.white
                                : Color(0xff555555),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    songs[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(songs[index].artist, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        itemCount: songs.length,
      ),
    );
  }
}

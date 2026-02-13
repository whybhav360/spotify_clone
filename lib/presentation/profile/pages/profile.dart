import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/core/configs/constants/constants.dart';
import 'package:spotify_clone/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify_clone/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify_clone/presentation/song_player/pages/song_player.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor: const Color(0xff2C2B2B),
        title: const Text("Profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Favorite Songs",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          const SizedBox(height: 15),

          Expanded(
            child: _favoriteSongs(),
          ),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          state.userEntity.imageURL ?? AppURLs.defaultImage,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.userEntity.fullName ?? 'No Name',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.userEntity.email ?? 'No Email',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.isDarkMode ? Colors.grey : Colors.black54,
                    ),
                  ),
                ],
              );
            }
            if (state is ProfileInfoFailure) {
              return const Center(child: Text("Please Try Again"));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
        builder: (context, state) {
          if (state is FavoriteSongsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteSongsLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SongPlayerPage(
                          songEntity: state.favoriteSongs[index],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  state.favoriteSongs[index].coverURL,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.favoriteSongs[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                state.favoriteSongs[index].artist,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            state.favoriteSongs[index].duration
                                .toString()
                                .replaceAll('.', ':'),
                          ),
                          const SizedBox(width: 20),
                          FavoriteButton(
                            songEntity: state.favoriteSongs[index],
                            key: UniqueKey(),
                            function: () {
                              context
                                  .read<FavoriteSongsCubit>()
                                  .removeSong(index);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemCount: state.favoriteSongs.length,
            );
          }
          if (state is FavoriteSongsFailure) {
            return Text("Please try Again");
          }
          return Container();
        },
      ),
    );
  }
}

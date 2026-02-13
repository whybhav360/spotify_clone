import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/presentation/home/widgets/new_songs.dart';
import 'package:spotify_clone/presentation/home/widgets/playlist.dart';
import 'package:spotify_clone/presentation/profile/pages/profile.dart';

import '../../../core/configs/assets/app_vectors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ProfilePage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.person),
                      ),
                      Center(
                        child: Transform.scale(
                          scale: 0.8,
                          child: SvgPicture.asset(AppVectors.logo),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ProfilePage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.person),
                      ),
                    ],
                  ),
                  _homeTopCard(),
                ],
              ),
              _tabs(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(children: [NewSongs(), Playlist()]),
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Image.asset(AppImages.homeArtist),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      dividerColor: Colors.transparent,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorColor: AppColors.primary,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      controller: _tabController,
      padding: EdgeInsets.symmetric(vertical: 41, horizontal: 16),
      tabs: [
        Text(
          'Songs',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        Text(
          'Videos',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        Text(
          'Artist',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        Text(
          'Podcasts',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ],
    );
  }
}

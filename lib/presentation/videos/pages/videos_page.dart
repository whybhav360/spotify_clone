import 'package:flutter/material.dart';
import 'package:spotify_clone/presentation/videos/pages/player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final videoUrls = [
  'https://www.youtube.com/watch?v=1wBpX0iFl5E',
  'https://www.youtube.com/watch?v=5AxWC49ZMzs',
  'https://www.youtube.com/watch?v=JSqUZFkRLr8',
  'https://www.youtube.com/watch?v=qEZf2q4W20g',
  'https://www.youtube.com/watch?v=jCbclWBV32o',
];

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          final videoID = YoutubePlayer.convertUrlToId(videoUrls[index]);
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PLayerScreen(videoId: videoID),
                ),
              );
            },
            child: Column(
              children: [
                Image.network(YoutubePlayer.getThumbnail(videoId: videoID!)),
              ],
            ),
          );
        },
      ),
    );
  }
}

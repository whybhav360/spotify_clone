import 'dart:convert';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
          final videoUrl = videoUrls[index];
          return VideoListItem(key: ValueKey(videoUrl), videoUrl: videoUrl);
        },
      ),
    );
  }
}

class VideoListItem extends StatefulWidget {
  final String videoUrl;

  const VideoListItem({super.key, required this.videoUrl});

  @override
  State<VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  String? _videoTitle;
  String? _videoID;
  String? _error;

  @override
  void initState() {
    super.initState();
    _videoID = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _fetchVideoTitle();
  }

  Future<void> _fetchVideoTitle() async {
    final videoID = _videoID;
    if (videoID == null) {
      if (mounted) {
        setState(() {
          _error = 'Invalid YouTube URL';
        });
      }
      return;
    }

    try {
      final uri = Uri.parse(
        'https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=$videoID&format=json',
      );
      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['title'] != null) {
          if (mounted) {
            setState(() {
              _videoTitle = data['title'];
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _error = 'Error: Title not found in response.';
            });
          }
        }
      } else {
        log('oEmbed error: ${response.statusCode} ${response.body}');
        if (mounted) {
          setState(() {
            _error = 'Error: ${response.statusCode} ${response.reasonPhrase}';
          });
        }
      }
    } on TimeoutException {
      log('oEmbed error: Timeout');
      if (mounted) {
        setState(() {
          _error = 'Error: Request timed out.';
        });
      }
    } catch (e) {
      log('Error fetching video title: $e');
      if (mounted) {
        setState(() {
          _error = 'Error: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoID = _videoID;
    if (videoID == null) {
      return const SizedBox.shrink();
    }

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
          Image.network(
            YoutubePlayer.getThumbnail(
              quality: ThumbnailQuality.standard,
              videoId: videoID,
            ),
          ),
          _buildTitleOrStatus(),
        ],
      ),
    );
  }

  Widget _buildTitleOrStatus() {
    if (_error != null) {
      return Text(
        _error!,
        style: const TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      );
    }
    if (_videoTitle != null) {
      return Text(
        _videoTitle!,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      );
    }
    return const CircularProgressIndicator();
  }
}

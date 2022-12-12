import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayerPage extends StatefulWidget {
  @override
  _MyVideoPlayerPageState createState() => _MyVideoPlayerPageState();
}

class _MyVideoPlayerPageState extends State<MyVideoPlayerPage> {
  late VideoPlayerController videoPlayerController;
  late Future<void> videoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
    videoPlayerFuture = videoPlayerController.initialize();
    videoPlayerController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flutter Video Player Sample')),
        body: FutureBuilder(
          future: videoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: VideoPlayer(videoPlayerController),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              videoPlayerController.value.isPlaying
                  ? videoPlayerController.pause()
                  : videoPlayerController.play();
            });
          },
          child: Icon(
            videoPlayerController.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
          ),
        ));
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

}
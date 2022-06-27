import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const Player());

List<String> links = [
  'https://assets.mixkit.co/videos/preview/mixkit-under-a-peripheral-road-with-two-avenues-on-the-sides-34560-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-road-of-a-city-with-many-cars-at-night-34561-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-waves-in-the-water-1164-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-pink-and-blue-ink-1192-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-green-ink-1196-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-yellow-and-orange-ink-1198-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-purple-and-white-ink-1203-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-red-frog-on-a-log-1487-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-blurred-view-of-sky-through-the-leaves-of-a-tree-34375-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-boardwalk-with-umbrellas-1165-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-defocused-view-of-the-water-reflecting-light-at-night-34379-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-abstract-video-of-unfocused-lights-flickering-in-the-dark-34380-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-abstract-video-of-unfocused-lights-flickering-in-the-dark-34380-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-white-marble-surface-with-gray-34498-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-sun-setting-or-rising-over-palm-trees-1170-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-weeds-waving-in-the-breeze-1178-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-yellow-and-white-flowers-in-a-tree-1181-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-sun-over-hills-1183-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-small-pink-flowers-1186-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-tree-branches-in-the-breeze-1188-large.mp4',
];

class Player extends StatelessWidget {
  const Player({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(viewportFraction: 1, keepPage: true);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          PageView.builder(
            controller: controller,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              index >= links.length ? index = index % links.length : null;

              return Video(
                link: links[index],
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              'Player',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class Video extends StatefulWidget {
  const Video({required this.link, Key? key}) : super(key: key);
  final String link;
  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.link)
      ..initialize().then(
        (_) {
          setState(() {
            _videoController.play();
          });
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return _videoController.value.isInitialized
        ? Stack(
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(
                      () {
                        _videoController.value.isPlaying
                            ? _videoController.pause()
                            : _videoController.play();
                      },
                    );
                  },
                  child: AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              ),
              _videoController.value.isPlaying
                  ? Container()
                  : Center(
                      child: TextButton(
                        onPressed: () {
                          setState(
                            () {
                              _videoController.value.isPlaying
                                  ? _videoController.pause()
                                  : _videoController.play();
                            },
                          );
                        },
                        child: const Icon(
                          Icons.pause,
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    ),
            ],
          )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}

import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class HomeScreenVideo extends StatefulWidget {
  final String videoAsset;

  const HomeScreenVideo({Key? key, required this.videoAsset}) : super(key: key);

  @override
  _HomeScreenVideoState createState() => _HomeScreenVideoState();
}

class _HomeScreenVideoState extends State<HomeScreenVideo> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAsset)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.setLooping(true); 
        _controller.play(); 
      }).catchError((error) {
      
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        : Center(child: CupertinoActivityIndicator(color: AppColors.dateTimeColor,));
  }
}

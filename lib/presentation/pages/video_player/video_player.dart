import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart'; // Import GoRouter

class SuccessVideoPlayer extends StatefulWidget {
  final String videoAsset; // Pass the extra data

  const SuccessVideoPlayer({
    Key? key,
    required this.videoAsset,
  }) : super(key: key);

  @override
  _SuccessVideoPlayerState createState() => _SuccessVideoPlayerState();
}

class _SuccessVideoPlayerState extends State<SuccessVideoPlayer> {
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
        _controller.play();
      }).catchError((error) {
    
      });

    // Listen for video completion
    _controller.addListener(() {
    
 
      if (_controller.value.isInitialized) {
        final isFinished =
            _controller.value.position >= _controller.value.duration;
        if (isFinished) {
          // Navigate to the dashboard
          GoRouter.of(context).goNamed(Routes.navDashboard);
        }
      } else {
        GoRouter.of(context).goNamed(
          Routes.signIn, // Pass the extra data
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textColor,
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CupertinoActivityIndicator(color: AppColors.dateTimeColor),
      ),
    );
  }
}

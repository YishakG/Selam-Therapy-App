import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../../core/constants/app_colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String channelName;
  final String subtitle;
  final int likes;
  final int comments;

  const VideoPlayerScreen({
    Key? key,
    required this.videoUrl,
    required this.title,
    required this.channelName,
    required this.subtitle,
    required this.likes,
    required this.comments,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    
    try {
      await _videoPlayerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 9 / 16, // Portrait mode for TikTok-style
        autoPlay: true,
        looping: true,
        showControls: false, // Hide default controls for custom UI
        allowFullScreen: false,
        allowMuting: true,
      );
      
      setState(() {
        _isInitialized = true;
      });
    } catch (error) {
      print('Error initializing video player: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error loading video. Please try again later.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video Player
          Center(
            child: _isInitialized
                ? AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Chewie(controller: _chewieController!),
                  )
                : const CircularProgressIndicator(color: Colors.white),
          ),

          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent, Colors.black87],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0, 0.4, 1],
                ),
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Bottom Info and Actions
          Positioned(
            left: 16,
            bottom: 60,
            right: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${widget.channelName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Right Side Action Buttons
          Positioned(
            right: 12,
            bottom: 80,
            child: Column(
              children: [
                _buildActionButton(Icons.favorite, widget.likes),
                const SizedBox(height: 20),
                _buildActionButton(Icons.chat_bubble_outline, widget.comments),
                const SizedBox(height: 20),
                _buildActionButton(Icons.share, null),
              ],
            ),
          ),

          // Tap to play/pause overlay
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                if (_videoPlayerController.value.isPlaying) {
                  _videoPlayerController.pause();
                } else {
                  _videoPlayerController.play();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, int? count) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.black38,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        if (count != null) ...[
          const SizedBox(height: 4),
          Text(
            '$count',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
} 
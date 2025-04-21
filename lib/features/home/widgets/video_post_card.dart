import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class VideoPostCard extends StatelessWidget {
  final String thumbnailUrl;
  final String title;
  final String subtitle;
  final String channelName;
  final int likes;
  final int comments;
  final VoidCallback? onTap;

  const VideoPostCard({
    Key? key,
    required this.thumbnailUrl,
    required this.title,
    required this.subtitle,
    required this.channelName,
    required this.likes,
    required this.comments,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 9 / 16, // Standard vertical video aspect ratio
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), // Rounded corners for the card
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 8),
                blurRadius: 16,
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Video Background Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[900],
                      child: const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.white54,
                          size: 48,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[900],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),

              // Dark Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.7), Colors.transparent, Colors.black.withOpacity(0.7)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0, 0.4, 1],
                    ),
                  ),
                ),
              ),

              // Bottom Left Text Info
              Positioned(
                left: 16,
                bottom: 60,
                right: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@$channelName',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 14,
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
                    _buildActionIcon(Icons.favorite, likes),
                    const SizedBox(height: 20),
                    _buildActionIcon(Icons.chat_bubble_outline, comments),
                    const SizedBox(height: 20),
                    _buildActionIcon(Icons.share, 0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, int count) {
    return GestureDetector(
      onTap: () {
        // Add any animations or effects here if needed (like a scale animation).
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 6),
          Text(
            count > 0 ? '$count' : '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SocialPostCard extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String subtitle;
  final String content;
  final int likes;
  final int comments;

  const SocialPostCard({
    Key? key,
    required this.profileImageUrl,
    required this.username,
    required this.subtitle,
    required this.content,
    required this.likes,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : null,
                  child: profileImageUrl.isEmpty
                      ? Icon(Icons.person, color: AppColors.primary)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey[700]),
                  onPressed: () {}, // Future: show options menu.
                )
              ],
            ),
            const SizedBox(height: 14),

            // Content
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Interaction Row
            Row(
              children: [
                _interactionButton(
                  icon: Icons.favorite_border,
                  count: likes,
                ),
                const SizedBox(width: 24),
                _interactionButton(
                  icon: Icons.chat_bubble_outline,
                  count: comments,
                ),
                const Spacer(),
                _interactionButton(
                  icon: Icons.share_outlined,
                  showCount: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _interactionButton({
    required IconData icon,
    int? count,
    bool showCount = true,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        // TODO: Add interaction logic
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: Colors.grey[700],
            ),
            if (showCount && count != null) ...[
              const SizedBox(width: 4),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

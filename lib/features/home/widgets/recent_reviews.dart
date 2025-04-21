import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class RecentReviews extends StatelessWidget {
  const RecentReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Reviews',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _ReviewItem(
            name: 'Client 1',
            rating: 4,
            comment: 'Great session! Very helpful and insightful. Looking forward to the next one.',
            timeAgo: '2 days ago',
          ),
          const Divider(height: 24),
          _ReviewItem(
            name: 'Client 2',
            rating: 4,
            comment: 'Great session! Very helpful and insightful. Looking forward to the next one.',
            timeAgo: '2 days ago',
          ),
          const Divider(height: 24),
          _ReviewItem(
            name: 'Client 3',
            rating: 4,
            comment: 'Great session! Very helpful and insightful. Looking forward to the next one.',
            timeAgo: '2 days ago',
          ),
        ],
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final String name;
  final int rating;
  final String comment;
  final String timeAgo;

  const _ReviewItem({
    required this.name,
    required this.rating,
    required this.comment,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person_outline, color: Colors.grey[400]),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: AppColors.primary,
                        size: 16,
                      );
                    }),
                    const SizedBox(width: 8),
                    Text(
                      timeAgo,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          comment,
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class ContentPerformanceCard extends StatelessWidget {
  final String title;
  final String views;
  final String likes;
  final String shares;
  final String comments;

  const ContentPerformanceCard({
    Key? key,
    required this.title,
    required this.views,
    required this.likes,
    required this.shares,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetric(Icons.play_arrow_outlined, views),
              _buildMetric(Icons.thumb_up_outlined, likes),
              _buildMetric(Icons.share_outlined, shares),
              _buildMetric(Icons.comment_outlined, comments),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
} 
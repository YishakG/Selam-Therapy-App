import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class EarningsChart extends StatelessWidget {
  const EarningsChart({Key? key}) : super(key: key);

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
            'Earnings Overview',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: CustomPaint(
              size: const Size(double.infinity, 200),
              painter: _BarChartPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final secondaryPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 0; i <= 8; i++) {
      final y = size.height - (i * size.height / 8);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Sample data
    final data = [
      [3, 1], // Mon
      [4, 2], // Tue
      [5, 1], // Wed
      [3, 2], // Thu
      [4, 1], // Fri
      [2, 1], // Sat
      [1, 1], // Sun
    ];

    final barWidth = size.width / (data.length * 2 + 1);
    
    for (var i = 0; i < data.length; i++) {
      final x = (i * 2 + 1) * barWidth;
      
      // First bar
      final height1 = size.height * (data[i][0] / 8);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, size.height - height1, barWidth * 0.8, height1),
          const Radius.circular(4),
        ),
        secondaryPaint,
      );

      // Second bar
      final height2 = size.height * (data[i][1] / 8);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x + barWidth, size.height - height2, barWidth * 0.8, height2),
          const Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';

class EarningsOverviewCard extends StatelessWidget {
  final double totalEarnings;
  final double monthlyEarnings;
  final double weeklyEarnings;

  const EarningsOverviewCard({
    Key? key,
    required this.totalEarnings,
    required this.monthlyEarnings,
    required this.weeklyEarnings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            l10n.earningsOverview,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          _buildEarningsRow(
            title: l10n.totalEarningsEtb(totalEarnings.toStringAsFixed(2)),
            value: totalEarnings,
            isTotal: true,
          ),
          const Divider(height: 32),
          _buildEarningsRow(
            title: 'Monthly',
            value: monthlyEarnings,
          ),
          const SizedBox(height: 16),
          _buildEarningsRow(
            title: 'Weekly',
            value: weeklyEarnings,
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsRow({
    required String title,
    required double value,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? AppColors.textPrimary : Colors.grey[600],
          ),
        ),
        Text(
          'ETB ${value.toStringAsFixed(2)}',
          style: GoogleFonts.manrope(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
} 
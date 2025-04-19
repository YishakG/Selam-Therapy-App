import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseTrainerProfilePage extends StatelessWidget {
  const CourseTrainerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(24),
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
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage('assets/images/trainer_profile.png'),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 16),
                // Name and Title
                Text(
                  'Dr. Wedajeneh',
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Psychotherapy Advocacy Trainer',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                // Contact Information
                _buildContactInfo(
                  Icons.email_outlined,
                  'dr.wedajeneh@example.com',
                ),
                const SizedBox(height: 12),
                _buildContactInfo(
                  Icons.phone_outlined,
                  '+251 91 234 5678',
                ),
                const SizedBox(height: 12),
                _buildContactInfo(
                  Icons.location_on_outlined,
                  'Addis Ababa, Ethiopia',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Professional Details
          Container(
            padding: const EdgeInsets.all(24),
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
                  l10n.professionalDetails,
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _buildProfessionalDetail(
                  Icons.school_outlined,
                  'Psychotherapy Specialist',
                ),
                const SizedBox(height: 12),
                _buildProfessionalDetail(
                  Icons.workspace_premium_outlined,
                  '15+ Years Experience',
                ),
                const SizedBox(height: 12),
                _buildProfessionalDetail(
                  Icons.access_time,
                  'Available for Consultations',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfessionalDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.manrope(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TherapistProfilePage extends ConsumerWidget {
  const TherapistProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
backgroundImage: const NetworkImage(
  'https://randomuser.me/api/portraits/women/44.jpg',
),

                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Tigist Waltenigus',
                      style: GoogleFonts.manrope(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      l10n.clinicalPsychologist,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      l10n.traumaAndAnxietySpecialist,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: Colors.pink[300],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // TODO: Navigate to settings
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            l10n.specializations,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSpecializationChip(l10n.traumaTherapy),
              _buildSpecializationChip(l10n.anxietyAndDepression),
              _buildSpecializationChip(l10n.familyCounseling),
              _buildSpecializationChip(l10n.youthPsychology),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            l10n.certifications,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildCertification(l10n.phdClinicalPsychology),
          _buildCertification(l10n.licensedClinicalPsychologist),
          _buildCertification(l10n.certifiedTraumaSpecialist),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.availability,
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to schedule editor
                },
                child: Text(
                  l10n.editSchedule,
                  style: TextStyle(color: Colors.pink[300]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildAvailabilityItem(
            Icons.access_time,
            '${l10n.monToFri}: 9:00 AM - 5:00 PM',
          ),
          _buildAvailabilityItem(
            Icons.access_time,
            '${l10n.saturday}: 10:00 AM - 2:00 PM',
          ),
          const SizedBox(height: 24),
          Text(
            l10n.sessionRates,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildSessionRate(
            '${l10n.individualSession} (1 ${l10n.hour})',
            '1,200 ETB',
          ),
          _buildSessionRate(
            '${l10n.coupleTherapy} (1.5 ${l10n.hours})',
            '1,800 ETB',
          ),
        ],
      ),
    );
  }

  Widget _buildSpecializationChip(String label) {
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.manrope(
          color: Colors.grey[700],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildCertification(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildAvailabilityItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionRate(String service, String rate) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            service,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            rate,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 
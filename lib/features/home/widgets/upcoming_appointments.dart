import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({Key? key}) : super(key: key);

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
            'Upcoming Appointments',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _AppointmentItem(
            time: '10:00 AM',
            date: 'Oct 15, 2023',
            name: 'Abebe Kebede',
            type: 'Video Call',
          ),
          const SizedBox(height: 12),
          _AppointmentItem(
            time: '2:00 PM',
            date: 'Oct 15, 2023',
            name: 'Sara Tekle',
            type: 'In-Person',
          ),
          const SizedBox(height: 12),
          _AppointmentItem(
            time: '11:30 AM',
            date: 'Oct 16, 2023',
            name: 'Dawit Haile',
            type: 'Video Call',
          ),
        ],
      ),
    );
  }
}

class _AppointmentItem extends StatelessWidget {
  final String time;
  final String date;
  final String name;
  final String type;

  const _AppointmentItem({
    required this.time,
    required this.date,
    required this.name,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    time,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    date,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 16, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    name,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    type == 'Video Call' ? Icons.videocam_outlined : Icons.person_pin_circle_outlined,
                    size: 16,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    type,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Upcoming',
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
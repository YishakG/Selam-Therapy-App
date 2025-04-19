import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/therapist_stats_card.dart';
import '../widgets/upcoming_appointments.dart';
import '../widgets/earnings_chart.dart';
import '../widgets/recent_reviews.dart';
import '../widgets/messages_page.dart';
import '../widgets/appointments_page.dart';
import '../widgets/therapist_profile_page.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TherapistHomePage extends ConsumerStatefulWidget {
  const TherapistHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<TherapistHomePage> createState() => _TherapistHomePageState();
}

class _TherapistHomePageState extends ConsumerState<TherapistHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            const SizedBox(width: 8),
            Text(
              'Selam Therapy',
              style: GoogleFonts.manrope(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black87),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.message_outlined, color: Colors.black87),
            onPressed: () {
              // TODO: Implement messages
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Dashboard Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TherapistStatsCard(
                        title: l10n.totalClients,
                        value: '48',
                        icon: Icons.people_outline,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        iconColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TherapistStatsCard(
                        title: l10n.totalSessions,
                        value: '156',
                        icon: Icons.calendar_today_outlined,
                        backgroundColor: Colors.green.withOpacity(0.1),
                        iconColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TherapistStatsCard(
                        title: l10n.totalEarnings,
                        value: '\$4,320',
                        icon: Icons.attach_money,
                        backgroundColor: Colors.orange.withOpacity(0.1),
                        iconColor: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TherapistStatsCard(
                        title: l10n.rating,
                        value: '4.8',
                        icon: Icons.star_outline,
                        backgroundColor: Colors.purple.withOpacity(0.1),
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const UpcomingAppointments(),
                const SizedBox(height: 24),
                const EarningsChart(),
                const SizedBox(height: 24),
                const RecentReviews(),
              ],
            ),
          ),
          // Messages Page
          const MessagesPage(),
          // Appointments Page
          const AppointmentsPage(),
          // Profile Page
          const TherapistProfilePage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.message_outlined),
            selectedIcon: const Icon(Icons.message),
            label: l10n.messages,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_today_outlined),
            selectedIcon: const Icon(Icons.calendar_today),
            label: l10n.appointments,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }
} 
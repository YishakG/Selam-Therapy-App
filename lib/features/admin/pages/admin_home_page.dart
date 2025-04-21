import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/admin_stats_card.dart';
import '../widgets/user_management_section.dart';
import '../widgets/platform_config_section.dart';
import '../widgets/content_moderation_section.dart';
import '../widgets/analytics_section.dart';
import '../widgets/payment_section.dart';
import '../widgets/security_section.dart';
import '../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminHomePage extends ConsumerStatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends ConsumerState<AdminHomePage> {
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
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(
                Icons.admin_panel_settings,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.adminDashboard,
                  style: GoogleFonts.manrope(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  l10n.systemAdministrator,
                  style: GoogleFonts.manrope(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, color: Colors.black87),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '5',
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // TODO: Implement system notifications
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Dashboard Overview
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.quickStats,
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AdminStatsCard(
                        title: l10n.totalUsers,
                        value: '2,458',
                        icon: Icons.people_outline,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        iconColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AdminStatsCard(
                        title: l10n.activeSessions,
                        value: '186',
                        icon: Icons.timer_outlined,
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
                      child: AdminStatsCard(
                        title: l10n.totalRevenue,
                        value: l10n.totalEarningsEtb('125,430'),
                        icon: Icons.attach_money,
                        backgroundColor: Colors.orange.withOpacity(0.1),
                        iconColor: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AdminStatsCard(
                        title: l10n.systemHealth,
                        value: '98%',
                        icon: Icons.health_and_safety_outlined,
                        backgroundColor: Colors.purple.withOpacity(0.1),
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const UserManagementSection(),
                const SizedBox(height: 24),
                const PlatformConfigSection(),
                const SizedBox(height: 24),
                const ContentModerationSection(),
                const SizedBox(height: 24),
                const AnalyticsSection(),
                const SizedBox(height: 24),
                const PaymentSection(),
                const SizedBox(height: 24),
                const SecuritySection(),
              ],
            ),
          ),
          // User Management Page
          const UserManagementSection(),
          // Platform Configuration Page
          const PlatformConfigSection(),
          // Content Moderation Page
          const ContentModerationSection(),
          // Analytics Page
          const AnalyticsSection(),
          // Payment Management Page
          const PaymentSection(),
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
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: l10n.dashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_outline),
            selectedIcon: const Icon(Icons.people),
            label: l10n.users,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.settings,
          ),
          NavigationDestination(
            icon: const Icon(Icons.content_paste_outlined),
            selectedIcon: const Icon(Icons.content_paste),
            label: l10n.content,
          ),
          NavigationDestination(
            icon: const Icon(Icons.analytics_outlined),
            selectedIcon: const Icon(Icons.analytics),
            label: l10n.analytics,
          ),
          NavigationDestination(
            icon: const Icon(Icons.payments_outlined),
            selectedIcon: const Icon(Icons.payments),
            label: l10n.payments,
          ),
        ],
      ),
    );
  }
} 
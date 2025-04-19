import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AppointmentsPage extends ConsumerStatefulWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends ConsumerState<AppointmentsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.appointments,
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildFilterChips(),
          const SizedBox(height: 16),
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: l10n.upcoming),
              Tab(text: l10n.past),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAppointmentsList(true),
                _buildAppointmentsList(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('all', l10n.all),
          const SizedBox(width: 8),
          _buildFilterChip('individual', l10n.individual),
          const SizedBox(width: 8),
          _buildFilterChip('couple', l10n.couple),
          const SizedBox(width: 8),
          _buildFilterChip('family', l10n.family),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    return FilterChip(
      selected: _selectedFilter == value,
      label: Text(label),
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
    );
  }

  Widget _buildAppointmentsList(bool isUpcoming) {
    // Dummy data for demonstration
    final appointments = List.generate(
      10,
      (index) => _AppointmentData(
        clientName: 'Client ${index + 1}',
        date: DateTime.now().add(
          Duration(days: isUpcoming ? index : -index - 1),
        ),
        time: '${9 + index % 8}:00 AM',
        type: index % 3 == 0 ? 'individual' : (index % 3 == 1 ? 'couple' : 'family'),
        status: isUpcoming
            ? (index % 2 == 0 ? 'confirmed' : 'pending')
            : (index % 2 == 0 ? 'completed' : 'cancelled'),
      ),
    );

    return ListView.separated(
      itemCount: appointments.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        if (_selectedFilter != 'all' && appointment.type != _selectedFilter) {
          return const SizedBox.shrink();
        }
        return _buildAppointmentCard(appointment);
      },
    );
  }

  Widget _buildAppointmentCard(_AppointmentData appointment) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('MMM d, yyyy');

    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointment.clientName,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _buildStatusChip(appointment.status),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  dateFormat.format(appointment.date),
                  style: GoogleFonts.manrope(color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  appointment.time,
                  style: GoogleFonts.manrope(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  appointment.type == 'individual'
                      ? Icons.person
                      : appointment.type == 'couple'
                          ? Icons.people
                          : Icons.family_restroom,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  appointment.type == 'individual'
                      ? l10n.individualSession
                      : appointment.type == 'couple'
                          ? l10n.coupleTherapy
                          : l10n.familyCounseling,
                  style: GoogleFonts.manrope(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final l10n = AppLocalizations.of(context)!;
    
    Color chipColor;
    Color textColor;
    String statusText;

    switch (status) {
      case 'confirmed':
        chipColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        statusText = l10n.confirmed;
        break;
      case 'pending':
        chipColor = Colors.orange[100]!;
        textColor = Colors.orange[700]!;
        statusText = l10n.pending;
        break;
      case 'completed':
        chipColor = Colors.blue[100]!;
        textColor = Colors.blue[700]!;
        statusText = l10n.completed;
        break;
      case 'cancelled':
        chipColor = Colors.red[100]!;
        textColor = Colors.red[700]!;
        statusText = l10n.cancelled;
        break;
      default:
        chipColor = Colors.grey[100]!;
        textColor = Colors.grey[700]!;
        statusText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: GoogleFonts.manrope(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _AppointmentData {
  final String clientName;
  final DateTime date;
  final String time;
  final String type;
  final String status;

  _AppointmentData({
    required this.clientName,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
  });
} 
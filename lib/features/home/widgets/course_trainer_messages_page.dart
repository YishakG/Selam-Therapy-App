import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseTrainerMessagesPage extends ConsumerWidget {
  const CourseTrainerMessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.messages,
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: l10n.searchMessages,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 24),
          // Message categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(l10n.all, true),
                const SizedBox(width: 8),
                _buildFilterChip(l10n.messages, false),
                const SizedBox(width: 8),
                _buildFilterChip(l10n.profile, false),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Messages list
          Expanded(
            child: ListView(
              children: [
                _buildMessageTile(
                  'Course Review Team',
                  'Your latest course module has been approved',
                  '2m ago',
                  true,
                ),
                _buildMessageTile(
                  'Student Support',
                  'New student enrollment in Advanced Flutter',
                  '1h ago',
                  false,
                ),
                _buildMessageTile(
                  'Admin Team',
                  'Monthly performance review available',
                  '3h ago',
                  false,
                ),
                // Add more message tiles as needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool value) {
        // TODO: Implement filter functionality
      },
      backgroundColor: isSelected ? AppColors.primary : Colors.grey[100],
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _buildMessageTile(String sender, String preview, String time, bool isUnread) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        child: Text(
          sender[0],
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        sender,
        style: TextStyle(
          fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        preview,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      onTap: () {
        // TODO: Implement message detail view
      },
    );
  }
} 
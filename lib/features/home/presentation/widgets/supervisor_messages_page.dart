import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';

class SupervisorMessagesPage extends StatelessWidget {
  const SupervisorMessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: l10n.searchMessages,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildFilterChip(l10n.allMessages, true),
              const SizedBox(width: 8),
              _buildFilterChip(l10n.unreadMessages, false),
              const SizedBox(width: 8),
              _buildFilterChip(l10n.starredMessages, false),
              const SizedBox(width: 8),
              _buildFilterChip(l10n.archivedMessages, false),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildMessageItem(
                context,
                name: 'Creator ${index + 1}',
                message: l10n.latestMessagePreview,
                time: '2h',
                unread: index == 0,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      onSelected: (bool value) {
        // TODO: Implement filter selection
      },
      backgroundColor: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.grey[100],
      selectedColor: AppColors.primary.withOpacity(0.1),
      labelStyle: GoogleFonts.manrope(
        color: isSelected ? AppColors.primary : Colors.grey[600],
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? AppColors.primary : Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildMessageItem(
    BuildContext context, {
    required String name,
    required String message,
    required String time,
    bool unread = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        child: Text(
          name[0],
          style: GoogleFonts.manrope(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            name,
            style: GoogleFonts.manrope(
              fontWeight: unread ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (unread) ...[
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
      subtitle: Text(
        message,
        style: GoogleFonts.manrope(
          color: Colors.grey[600],
          fontSize: 13,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        time,
        style: GoogleFonts.manrope(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      onTap: () {
        // TODO: Implement message tap
      },
    );
  }
} 
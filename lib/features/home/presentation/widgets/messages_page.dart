import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessagesPage extends ConsumerStatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends ConsumerState<MessagesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
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
            l10n.messages,
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildSearchBar(),
          const SizedBox(height: 16),
          _buildMessageFilters(),
          const SizedBox(height: 16),
          Expanded(
            child: _buildMessagesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: l10n.searchMessages,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildMessageFilters() {
    final l10n = AppLocalizations.of(context)!;
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip(Icons.all_inbox, l10n.allMessages, true),
          const SizedBox(width: 8),
          _buildFilterChip(Icons.mark_email_unread, l10n.unreadMessages, false),
          const SizedBox(width: 8),
          _buildFilterChip(Icons.star_border, l10n.starredMessages, false),
          const SizedBox(width: 8),
          _buildFilterChip(Icons.archive_outlined, l10n.archivedMessages, false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(IconData icon, String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        showCheckmark: false,
        avatar: Icon(
          icon,
          size: 18,
          color: isSelected ? AppColors.primary : Colors.grey[600],
        ),
        label: Text(
          label,
          style: GoogleFonts.manrope(
            color: isSelected ? AppColors.primary : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.transparent,
        selectedColor: AppColors.primary.withOpacity(0.1),
        shape: StadiumBorder(
          side: BorderSide(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
          ),
        ),
        onSelected: (bool selected) {
          // TODO: Implement filter functionality
        },
      ),
    );
  }

  Widget _buildMessagesList() {
    // Dummy data for demonstration
    final messages = [
      _MessageData(
        senderName: 'Abebe Kebede',
        lastMessage: 'Thank you for the session today. It was very helpful.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        unreadCount: 2,
        isOnline: true,
      ),
      _MessageData(
        senderName: 'Sara Tadesse',
        lastMessage: 'Can we reschedule tomorrow\'s appointment?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        unreadCount: 0,
        isOnline: false,
      ),
      _MessageData(
        senderName: 'Dawit Haile',
        lastMessage: 'I\'ve been practicing the techniques you taught me.',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        unreadCount: 1,
        isOnline: true,
      ),
    ];

    if (messages.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      itemCount: messages.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final message = messages[index];
        if (_searchQuery.isNotEmpty &&
            !message.senderName.toLowerCase().contains(_searchQuery.toLowerCase()) &&
            !message.lastMessage.toLowerCase().contains(_searchQuery.toLowerCase())) {
          return const SizedBox.shrink();
        }
        return _buildMessageTile(message);
      },
    );
  }

  Widget _buildMessageTile(_MessageData message) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to chat detail
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    'https://ui-avatars.com/api/?name=${Uri.encodeComponent(message.senderName)}&background=random&size=100'
                  ),
                ),
                if (message.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.senderName,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: message.unreadCount > 0
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      Text(
                        timeago.format(message.timestamp),
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: message.unreadCount > 0
                                ? Colors.black87
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                      if (message.unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message.unreadCount.toString(),
                            style: GoogleFonts.manrope(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noMessages,
            style: GoogleFonts.manrope(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.startNewChat,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageData {
  final String senderName;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool isOnline;

  _MessageData({
    required this.senderName,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.isOnline,
  });
} 
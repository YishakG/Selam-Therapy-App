import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/content_creator_messages_page.dart';
import '../widgets/content_creator_profile_page.dart';
import '../widgets/content_performance_card.dart';
import '../widgets/scheduled_content_card.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContentCreatorHomePage extends ConsumerStatefulWidget {
  const ContentCreatorHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ContentCreatorHomePage> createState() => _ContentCreatorHomePageState();
}

class _ContentCreatorHomePageState extends ConsumerState<ContentCreatorHomePage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: l10n.searchTopics,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.black87),
                onPressed: () {
                  // TODO: Implement notifications
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '3',
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
          IconButton(
            icon: const Icon(Icons.message_outlined, color: Colors.black87),
            onPressed: () {
              setState(() {
                _selectedIndex = 1; // Switch to messages tab
              });
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Home Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.contentPerformance,
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                ContentPerformanceCard(
                  title: l10n.mentalHealthAwareness,
                  views: '12.5K',
                  likes: '850',
                  shares: '234',
                  comments: '156',
                ),
                const SizedBox(height: 12),
                ContentPerformanceCard(
                  title: l10n.wellnessTips,
                  views: '8.2K',
                  likes: '645',
                  shares: '189',
                  comments: '92',
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.scheduledContent,
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                ScheduledContentCard(
                  title: l10n.selfCareRoutines,
                  scheduledTime: l10n.tomorrowAt('10:00 AM'),
                  onEdit: () {
                    // TODO: Implement edit functionality
                  },
                ),
                const SizedBox(height: 12),
                ScheduledContentCard(
                  title: l10n.mindfulnessPractice,
                  scheduledTime: l10n.fridayAt('2:00 PM'),
                  onEdit: () {
                    // TODO: Implement edit functionality
                  },
                ),
              ],
            ),
          ),
          // Messages Page
          const ContentCreatorMessagesPage(),
          // Content Page
          _buildContentPage(),
          // Profile Page
          const ContentCreatorProfilePage(),
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
            icon: const Icon(Icons.video_library_outlined),
            selectedIcon: const Icon(Icons.video_library),
            label: l10n.content,
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

  Widget _buildContentPage() {
    return const Center(
      child: Text('Content Management'),
    );
  }
} 
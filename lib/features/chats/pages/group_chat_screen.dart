import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../services/chat_service.dart';
import 'package:selam_app/core/constants/app_colors.dart';

// Custom Message class to represent chat messages
class Message {
  final String id; // Document ID or temporary ID
  final String senderId;
  final String content;
  final Timestamp timestamp;
  final String? attachment; // Optional attachment URL
  final bool isTemporary; // Flag for optimistic updates
  final DocumentReference? reference; // For Firestore messages

  Message({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    this.attachment,
    this.isTemporary = false,
    this.reference,
  });

  // Create from Firestore DocumentSnapshot
  factory Message.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return Message(
      id: doc.id,
      senderId: data?['senderId'] ?? '',
      content: data?['content'] ?? '',
      timestamp: data?['timestamp'] ?? Timestamp.now(),
      attachment: data?['attachment'],
      reference: doc.reference,
    );
  }

  // Create for temporary message
  factory Message.temporary({
    required String senderId,
    required String content,
    required Timestamp timestamp,
    String? attachment,
  }) {
    return Message(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      senderId: senderId,
      content: content,
      timestamp: timestamp,
      attachment: attachment,
      isTemporary: true,
    );
  }
}

// Widget to display a single message
class MessageWidget extends StatelessWidget {
  final Message message;
  final String currentUserId;
  final bool isTherapist;
  final Future<String> Function(String) getUsername;
  final VoidCallback? onDelete;

  const MessageWidget({
    super.key,
    required this.message,
    required this.currentUserId,
    required this.isTherapist,
    required this.getUsername,
    this.onDelete,
  });

  // Format timestamp to a human-readable string
  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return DateFormat('h:mm a').format(dateTime); // e.g., 3:45 PM
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday, ${DateFormat('h:mm a').format(dateTime)}';
    } else {
      return DateFormat('MMM d, h:mm a')
          .format(dateTime); // e.g., Apr 27, 3:45 PM
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMe = message.senderId == currentUserId;
    return GestureDetector(
      onLongPress: (isMe || isTherapist) && message.reference != null
          ? () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    AppLocalizations.of(context)?.deleteMessage ??
                        'Delete Message',
                    style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    AppLocalizations.of(context)?.confirmDeleteMessage ??
                        'Are you sure you want to delete this message?',
                    style: GoogleFonts.manrope(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(
                        AppLocalizations.of(context)?.cancel ?? 'Cancel',
                        style:
                            GoogleFonts.manrope(color: AppColors.textSecondary),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        AppLocalizations.of(context)?.delete ?? 'Delete',
                        style: GoogleFonts.manrope(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
              if (confirm == true && onDelete != null) {
                onDelete!();
              }
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.primary : AppColors.primaryBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: isMe
                        ? const Radius.circular(20)
                        : const Radius.circular(0),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    // Display sender name and timestamp in a row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: FutureBuilder<String>(
                            future: getUsername(message.senderId),
                            builder: (context, snapshot) {
                              final name = snapshot.data ?? 'Unknown User';
                              return Text(
                                name,
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w700,
                                  color: isMe
                                      ? Colors.white
                                      : AppColors.textPrimary,
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatTimestamp(message.timestamp),
                          style: GoogleFonts.manrope(
                            color:
                                isMe ? Colors.white70 : AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Display attachment if present
                    if (message.attachment != null)
                      GestureDetector(
                        onTap: () async {
                          final url = Supabase.instance.client.storage
                              .from('group-attachments')
                              .getPublicUrl(message.attachment!);
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)
                                          ?.cannotOpenAttachment ??
                                      'Cannot open attachment',
                                ),
                              ),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.attachment,
                                size: 16, color: AppColors.primary),
                            const SizedBox(width: 4),
                            Text(
                              AppLocalizations.of(context)?.viewAttachment ??
                                  'View Attachment',
                              style: GoogleFonts.manrope(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (message.attachment != null) const SizedBox(height: 8),
                    // Display message content
                    Text(
                      message.content,
                      style: GoogleFonts.manrope(
                        color: isMe ? Colors.white : AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupChatScreen extends StatefulWidget {
  final String groupId;
  const GroupChatScreen({required this.groupId, super.key});

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final user = FirebaseAuth.instance.currentUser;
  final ScrollController _scrollController = ScrollController();
  bool isTherapist = false;
  List<Message> messages = []; // For paginated and temporary messages
  bool isLoadingMore = false;
  bool hasMoreMessages = true;
  bool _isScrollDebounced = false;
  final int pageSize = 10;
  DocumentSnapshot? lastDocument;
  final Map<String, String> _usernameCache = {};

  @override
  void initState() {
    super.initState();
    print('Initializing GroupChatScreen for group: ${widget.groupId}');
    _checkTherapistRole();
    _loadInitialMessages();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _checkTherapistRole() async {
    try {
      isTherapist = await _chatService.isTherapist();
      print('User isTherapist: $isTherapist');
      setState(() {});
    } catch (e) {
      print('Error checking therapist role: $e');
      isTherapist = false;
      setState(() {});
    }
  }

  Future<void> _loadInitialMessages() async {
    print('Loading initial $pageSize messages for group: ${widget.groupId}');
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('group_chats')
          .doc(widget.groupId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(pageSize)
          .get();
      setState(() {
        messages =
            querySnapshot.docs.map((doc) => Message.fromDocument(doc)).toList();
        lastDocument =
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
        hasMoreMessages = querySnapshot.docs.length == pageSize;
        print('Loaded ${messages.length} initial messages');
      });
    } catch (e) {
      print('Error loading initial messages: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.errorLoadingMessages ??
                'Error loading messages: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loadMoreMessages() async {
    if (isLoadingMore || !hasMoreMessages) return;
    print('Loading more messages for group: ${widget.groupId}');
    setState(() {
      isLoadingMore = true;
    });
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('group_chats')
          .doc(widget.groupId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .startAfterDocument(lastDocument!)
          .limit(pageSize)
          .get();
      setState(() {
        messages
            .addAll(querySnapshot.docs.map((doc) => Message.fromDocument(doc)));
        lastDocument = querySnapshot.docs.isNotEmpty
            ? querySnapshot.docs.last
            : lastDocument;
        hasMoreMessages = querySnapshot.docs.length == pageSize;
        isLoadingMore = false;
        print(
            'Loaded ${querySnapshot.docs.length} more messages, total: ${messages.length}');
      });
    } catch (e) {
      print('Error loading more messages: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.errorLoadingMessages ??
                'Error loading more messages: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  void _onScroll() {
    if (_isScrollDebounced) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      print('Scroll reached bottom, triggering load more');
      _isScrollDebounced = true;
      _loadMoreMessages().then((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _isScrollDebounced = false;
        });
      });
    }
  }

  Future<void> _pickAndSendFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx'],
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final fileSize = await file.length();
      if (fileSize > 10 * 1024 * 1024) {
        // 10MB limit
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.fileTooLarge ??
                  'File size exceeds 10MB limit',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      final fileName = result.files.single.name;
      print('Sending attachment: $fileName');
      final tempMessage = Message.temporary(
        senderId: user!.uid,
        content: 'Attachment: $fileName',
        timestamp: Timestamp.now(),
        attachment: 'temp_attachment',
      );
      setState(() {
        messages.insert(0, tempMessage);
        print('Added temporary attachment message to UI: $fileName');
      });
      try {
        await _chatService.sendAttachment(widget.groupId, file, fileName);
        print('Attachment sent to Firestore');
      } catch (e) {
        print('Error sending attachment: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.errorSendingAttachment ??
                  'Error sending attachment: $e',
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          messages.remove(tempMessage);
        });
      }
    }
  }

  Future<void> _sendMessage(String content) async {
    if (content.trim().isEmpty || user == null) return;
    print('Sending message: $content');
    final tempMessage = Message.temporary(
      senderId: user!.uid,
      content: content,
      timestamp: Timestamp.now(),
    );
    setState(() {
      messages.insert(0, tempMessage);
      print('Added temporary message to UI: $content');
    });
    try {
      await _chatService.sendMessage(widget.groupId, content);
      print('Message sent to Firestore');
    } catch (e) {
      print('Error sending message: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.errorSendingMessage ??
                'Error sending message: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        messages.remove(tempMessage);
      });
    }
  }

  Future<String> _getUsername(String userId) async {
    if (_usernameCache.containsKey(userId)) {
      return _usernameCache[userId]!;
    }
    try {
      // Check Clients collection
      final clientDoc = await FirebaseFirestore.instance
          .collection('Clients')
          .doc(userId)
          .get();
      if (clientDoc.exists) {
        final data = clientDoc.data()!;
        final firstName = data['first_name'] as String? ?? '';
        final lastName = data['last_name'] as String? ?? '';
        final fullName = '$firstName $lastName'.trim();
        final displayName = fullName.isNotEmpty ? fullName : 'Unknown User';
        _usernameCache[userId] = displayName;
        return displayName;
      }
      // Fallback to Therapists collection
      final therapistDoc = await FirebaseFirestore.instance
          .collection('Therapists')
          .doc(userId)
          .get();
      if (therapistDoc.exists) {
        final data = therapistDoc.data()!;
        final firstName = data['first_name'] as String? ?? '';
        final lastName = data['last_name'] as String? ?? '';
        final fullName = '$firstName $lastName'.trim();
        final displayName = fullName.isNotEmpty ? fullName : 'Unknown User';
        _usernameCache[userId] = displayName;
        return displayName;
      }
      // No name found in either collection
      _usernameCache[userId] = 'Unknown User';
      return 'Unknown User';
    } catch (e) {
      print('Error fetching username for $userId: $e');
      _usernameCache[userId] = 'Unknown User';
      return 'Unknown User';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text(
            AppLocalizations.of(context)?.pleaseLogin ??
                'Please login to view the chat',
            style: GoogleFonts.manrope(
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surfaceBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.groupId.capitalize(),
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('group_chats')
                  .doc(widget.groupId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .limit(pageSize)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('Stream error: ${snapshot.error}');
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)?.errorLoadingMessages ??
                          'Error loading messages: ${snapshot.error}',
                      style: GoogleFonts.manrope(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting &&
                    messages.isEmpty) {
                  return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary));
                }
                if (!snapshot.hasData && !snapshot.hasError) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)?.offlineMessage ??
                          'You are offline. Messages may not load.',
                      style: GoogleFonts.manrope(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                // Process messages from stream
                List<Message> streamMessages = [];
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  streamMessages = snapshot.data!.docs
                      .map((doc) => Message.fromDocument(doc))
                      .toList();
                }

                // Combine with paginated and temporary messages, ensuring no duplicates
                final displayMessages = [
                  ...streamMessages,
                  ...messages.where((m) => !streamMessages.any((sm) =>
                      sm.id == m.id ||
                      (sm.content == m.content && sm.senderId == m.senderId))),
                ]..sort((a, b) => b.timestamp.compareTo(a.timestamp));

                if (displayMessages.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)?.noMessages ??
                          'No messages yet',
                      style: GoogleFonts.manrope(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: displayMessages.length + (isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == displayMessages.length && isLoadingMore) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primary));
                    }
                    final message = displayMessages[index];
                    return MessageWidget(
                      message: message,
                      currentUserId: user!.uid,
                      isTherapist: isTherapist,
                      getUsername: _getUsername,
                      onDelete: () async {
                        try {
                          await _chatService.deleteMessage(
                              widget.groupId, message.id);
                          setState(() {
                            messages.removeWhere((m) => m.id == message.id);
                            print('Deleted message: ${message.content}');
                          });
                        } catch (e) {
                          print('Error deleting message: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)
                                        ?.errorDeletingMessage ??
                                    'Error deleting message: $e',
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: AppColors.primaryBackground,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, size: 24),
                  color: AppColors.primary,
                  onPressed: _pickAndSendFile,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: GoogleFonts.manrope(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.inputFieldBackground,
                      hintText: AppLocalizations.of(context)?.typeMessage ??
                          'Type a message...',
                      hintStyle: GoogleFonts.manrope(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, size: 24),
                  color: AppColors.primary,
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      _sendMessage(_messageController.text.trim());
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Extension to capitalize strings
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

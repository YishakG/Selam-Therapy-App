import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SupabaseClient _supabase = Supabase.instance.client;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  

  // Check if the user is a member of the group
  // Future<bool> isGroupMember(String groupId) async {
  //   if (userId == null) return false;
  //   final doc = await _firestore
  //       .collection('group_chats')
  //       .doc(groupId)
  //       .collection('members')
  //       .doc(userId)
  //       .get();
  //   return doc.exists;
  // }

  // Send a text message
  Future<void> sendMessage(String groupId, String content) async {
    if (userId == null) {
      throw Exception('Please sign in to send a message');
    }
    if (content.isEmpty) {
      throw Exception('Message cannot be empty');
    }
    final groupDoc =
        await _firestore.collection('group_chats').doc(groupId).get();
    if (!groupDoc.exists) {
      throw Exception('This group does not exist');
    }
    // if (!(await isGroupMember(groupId))) {
    //   throw Exception('Please join the group to send messages');
    // }
    try {
      await _firestore
          .collection('group_chats')
          .doc(groupId)
          .collection('messages')
          .add({
        'senderId': userId,
        'content': content,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      throw Exception(e.toString().contains('permission-denied')
          ? 'You do not have permission to send messages'
          : 'Failed to send message: $e');
    }
  }

  // Upload and send an attachment
  Future<void> sendAttachment(
      String groupId, File file, String fileName) async {
    if (userId == null) {
      throw Exception('Please sign in to send an attachment');
    }
    final groupDoc =
        await _firestore.collection('group_chats').doc(groupId).get();
    if (!groupDoc.exists) {
      throw Exception('This group does not exist');
    }
    // if (!(await isGroupMember(groupId))) {
    //   throw Exception('Please join the group to send attachments');
    // }
    
    try {
      final storagePath =
          '$groupId/$userId/${DateTime.now().millisecondsSinceEpoch}_$fileName';
      await _supabase.storage
          .from('group-attachments')
          .upload(storagePath, file);
      await _firestore
          .collection('group_chats')
          .doc(groupId)
          .collection('messages')
          .add({
        'senderId': userId,
        'content': 'Attachment: $fileName',
        'attachment': storagePath,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      throw Exception(e.toString().contains('permission-denied')
          ? 'You do not have permission to send attachments'
          : 'Failed to send attachment: $e');
    }
  }

  // Join a group
  Future<void> joinGroup(String groupId) async {
    if (userId == null) {
      throw Exception('Please sign in to join the group');
    }
    final groupDoc =
        await _firestore.collection('group_chats').doc(groupId).get();
    if (!groupDoc.exists) {
      throw Exception('This group does not exist');
    }
    // if (await isGroupMember(groupId)) {
    //   throw Exception('You are already a member of this group');
    // }
    // Group-specific restrictions
    final userDoc = await _firestore.collection('Clients').doc(userId).get();
    if (groupId == 'teenage') {
      if (!userDoc.exists) {
        throw Exception('You must be a client to join the teenage group');
      }
    } else if (groupId == 'careers') {
      if (!userDoc.exists || !userDoc.data()!.containsKey('profession')) {
        throw Exception('A profession is required to join the careers group');
      }
    } else if (groupId == 'family') {
      if (!userDoc.exists || !userDoc.data()!.containsKey('familyStatus')) {
        throw Exception('A family status is required to join the family group');
      }
    } else if (groupId == 'relationship') {
      if (!userDoc.exists ||
          !userDoc.data()!.containsKey('relationshipStatus')) {
        throw Exception(
            'A relationship status is required to join the relationship group');
      }
    }
    // No restrictions for 'individual'
    try {
      await _firestore
          .collection('group_chats')
          .doc(groupId)
          .collection('members')
          .doc(userId)
          .set({
        'joinedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception(e.toString().contains('permission-denied')
          ? 'You do not have permission to join this group'
          : 'Failed to join group: $e');
    }
  }

  // Check if user is a therapist
  Future<bool> isTherapist() async {
    if (userId == null) return false;
    final doc = await _firestore.collection('Therapists').doc(userId).get();
    return doc.exists;
  }

  // Delete a message
  Future<void> deleteMessage(String groupId, String messageId) async {
    if (userId == null) {
      throw Exception('Please sign in to delete a message');
    }
    final groupDoc =
        await _firestore.collection('group_chats').doc(groupId).get();
    if (!groupDoc.exists) {
      throw Exception('This group does not exist');
    }
    try {
      final messageDoc = await _firestore
          .collection('group_chats')
          .doc(groupId)
          .collection('messages')
          .doc(messageId)
          .get();
      if (!messageDoc.exists) {
        throw Exception('Message does not exist');
      }
      final message = messageDoc.data()!;
      final isTherapistUser = await isTherapist();
      if (message['senderId'] != userId && !isTherapistUser) {
        throw Exception('You do not have permission to delete this message');
      }
      await _firestore
          .collection('group_chats')
          .doc(groupId)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      throw Exception(e.toString().contains('permission-denied')
          ? 'You do not have permission to delete this message'
          : 'Failed to delete message: $e');
    }
  }
}

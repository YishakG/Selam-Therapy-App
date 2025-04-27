import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> initializeGroupChats() async {
  // Check if the user is authenticated
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception(
        'User not authenticated. Please sign in before initializing group chats.');
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();

  // List of groups to create
  final groups = [
    {
      'id': 'teenage',
      'name': 'Teenage',
      'description': 'Teen mental health and support',
    },
    {
      'id': 'careers',
      'name': 'Careers',
      'description': 'Career guidance and support',
    },
    {
      'id': 'family',
      'name': 'Family',
      'description': 'Family relationships and support',
    },
    {
      'id': 'individual',
      'name': 'Individual',
      'description': 'Personal growth and individual support',
    },
    {
      'id': 'relationship',
      'name': 'Relationship',
      'description': 'Relationship advice and support',
    },
  ];

  // Check which groups already exist to avoid duplicates
  for (var group in groups) {
    final groupRef = firestore.collection('group_chats').doc(group['id']);
    final doc = await groupRef.get();
    if (!doc.exists) {
      batch.set(groupRef, {
        'name': group['name'],
        'description': group['description'],
        'createdAt': Timestamp.now(),
      });
      print('Adding group to batch: ${group['id']}');
    } else {
      print('Group already exists, skipping: ${group['id']}');
    }
  }

  // Commit the batch
  try {
    await batch.commit();
    print('Successfully initialized group chats');
  } catch (e) {
    print('Failed to initialize group chats: $e');
    throw Exception('Failed to initialize group chats: $e');
  }
}

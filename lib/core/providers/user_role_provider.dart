import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserRole {
  client,
  therapist,
  admin,
}

final userRoleProvider = StateProvider<UserRole>((ref) => UserRole.therapist); 
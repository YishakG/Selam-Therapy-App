import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/user_role.dart';

final userRoleProvider = StateProvider<UserRole>((ref) => UserRole.therapist);

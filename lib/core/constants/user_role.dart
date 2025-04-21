enum UserRole {
  client,
  therapist,
  admin,
  contentCreator,
  contentSupervisor,
  courseTrainer;

  String get name {
    switch (this) {
      case UserRole.client:
        return 'Client';
      case UserRole.therapist:
        return 'Therapist';
      case UserRole.admin:
        return 'Admin';
      case UserRole.contentCreator:
        return 'Content Creator';
      case UserRole.contentSupervisor:
        return 'Content Supervisor';
      case UserRole.courseTrainer:
        return 'Course Trainer';
    }
  }
} 
class Course {
  final String id;
  final String title;
  final String instructor;
  final String duration;
  final String description;
  final String price;
  final String imageUrl;
  final bool isEnrolled;
  final double progress;

  const Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.duration,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isEnrolled = false,
    this.progress = 0.0,
  });

  Course copyWith({
    String? id,
    String? title,
    String? instructor,
    String? duration,
    String? description,
    String? price,
    String? imageUrl,
    bool? isEnrolled,
    double? progress,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      instructor: instructor ?? this.instructor,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isEnrolled: isEnrolled ?? this.isEnrolled,
      progress: progress ?? this.progress,
    );
  }
} 
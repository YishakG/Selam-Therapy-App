import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/course.dart';
import '../../domain/usecases/get_courses.dart';

final coursesProvider = FutureProvider<List<Course>>((ref) async {
  // TODO: Implement actual repository and use case
  // For now, return mock data
  return [
    Course(
      id: '1',
      title: 'የጤና ምክር ኮርስ',
      instructor: 'ዶ/ር ማርያም',
      duration: '2 ሰአታት',
      description: 'የጤና ምክር ኮርስ ለሁሉም የሚገባ ነው። ይህ ኮርስ የጤና ምክር ለመስጠት የሚያስፈልጉትን መሰረታዊ ነገሮች ያስተምራል።',
      price: 'ብር 500',
      imageUrl: 'https://picsum.photos/200',
    ),
    Course(
      id: '2',
      title: 'የልጆች እንክብካቤ ኮርስ',
      instructor: 'ወ/ር ሰላም',
      duration: '3 ሰአታት',
      description: 'የልጆች እንክብካቤ ኮርስ ለወላጆች እና ለልጆች እንክብካቤ ለሚሰጡ ሰዎች የተዘጋጀ ነው።',
      price: 'ብር 750',
      imageUrl: 'https://picsum.photos/201',
    ),
  ];
}); 
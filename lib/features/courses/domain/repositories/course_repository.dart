import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/course.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<Course>>> getCourses();
  Future<Either<Failure, Course>> getCourseById(String id);
  Future<Either<Failure, void>> enrollInCourse(String courseId);
  Future<Either<Failure, void>> unenrollFromCourse(String courseId);
  Future<Either<Failure, List<Course>>> getEnrolledCourses();
} 
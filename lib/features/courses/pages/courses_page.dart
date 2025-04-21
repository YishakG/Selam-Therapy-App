import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../widgets/course_card.dart';
import '../providers/courses_provider.dart';

class CoursesPage extends ConsumerWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final coursesState = ref.watch(coursesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          l10n.courses,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: coursesState.when(
        data: (courses) => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return CourseCard(
              title: course.title,
              instructor: course.instructor,
              duration: course.duration,
              description: course.description,
              price: course.price,
              imageUrl: course.imageUrl,
              onTap: () {
                // TODO: Navigate to course details
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Course: ${course.title}')),
                );
              },
            );
          },
        ),
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          error: error.toString(),
          onRetry: () => ref.refresh(coursesProvider),
        ),
      ),
    );
  }
} 
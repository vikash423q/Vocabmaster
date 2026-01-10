import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/daily_review_bloc.dart';
import '../../../core/models/progress.dart';
import '../../../../app/app_router.dart';

class DailyStackScreen extends StatelessWidget {
  const DailyStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Review')),
      body: BlocProvider(
        create: (context) => DailyReviewBloc()..add(LoadDailyStack()),
        child: BlocBuilder<DailyReviewBloc, DailyReviewState>(
          builder: (context, state) {
            if (state is DailyReviewLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DailyReviewLoaded) {
              if (state.items.isEmpty) {
                return const Center(
                  child: Text('No words to review today!'),
                );
              }
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    title: Text(item.word),
                    subtitle: Text('Scheduled: ${item.scheduledDate}'),
                    trailing: item.isReviewed
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.radio_button_unchecked),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.wordDetail,
                        arguments: {'wordId': item.wordId},
                      );
                    },
                  );
                },
              );
            } else if (state is DailyReviewError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/commons/widgets/custom_snack_bar.dart';
import 'package:todo/features/task/bloc/task_bloc.dart';
import 'package:todo/features/task/widgets/base_page.dart';
import 'package:todo/features/task/widgets/create_task_card.dart';
import 'package:todo/features/task/widgets/empty_task_widget.dart';
import 'package:todo/features/task/widgets/error_widget.dart';
import 'package:todo/features/task/widgets/list_task.dart';
import 'package:todo/features/task/widgets/text_loading_widget.dart';
import 'package:todo/gen/colors.gen.dart';

class AllTaskPage extends StatefulWidget {
  const AllTaskPage({Key? key}) : super(key: key);

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage> {
  @override
  void initState() {
    super.initState();

    context.read<AllTaskBloc>().add(const TaskFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Text(
                  'Tasks',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: ColorName.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: BlocConsumer<AllTaskBloc, TaskState>(
                    listener: (context, state) {
                      if (state is TaskCreatedSuccess || state is TaskUpdatedSuccess) {
                        context.read<AllTaskBloc>().add(const TaskFetched());
                        context.read<CompleteTaskBloc>().add(const TaskFetched(isDone: true));
                        context.read<IncompleteTaskBloc>().add(const TaskFetched(isDone: false));
                      } else if (state is TaskCreatedFailure) {
                        showErrorSnackBBar(context: context, message: state.message);
                      } else if (state is TaskUpdatedFailure) {
                        showErrorSnackBBar(context: context, message: state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is TaskFetchedSuccess) {
                        if (state.tasks.isEmpty) {
                          return const EmptyTaskWidget(message: "There's no task yet!\n Add a new Task ✨");
                        }

                        return ListTask(
                          tasks: state.tasks,
                          onCheckBoxTap: (id, value) {
                            context.read<AllTaskBloc>().add(TaskUpdated(
                              id: id,
                              isDone: value,
                            ));
                          },
                        );
                      } else if (state is TaskFetchedFailure) {
                        return ErrorFailureWidget(message: state.message);
                      } else {
                        return const TextLoadingWidget();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 64.0),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CreateTaskCard(),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/task/bloc/task_bloc.dart';
import 'package:todo/gen/colors.gen.dart';

class CreateTaskCard extends StatefulWidget {
  const CreateTaskCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateTaskCard> createState() => _CreateTaskCardState();
}

class _CreateTaskCardState extends State<CreateTaskCard> {
  final _controller = TextEditingController();
  bool _creatable = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _creatable = _controller.text.isNotEmpty);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: ColorName.background,
      child: Container(
        decoration: BoxDecoration(
          color: ColorName.secondaryBackground,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: 5,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Add a Task',
                  hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorName.primary),
                  contentPadding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 8.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: _creatable
                  ? TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<AllTaskBloc>().add(TaskCreated(content: _controller.text));
                        _controller.clear();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: ColorName.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      child: Icon(
                        Icons.add,
                        color: ColorName.primary,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo/gen/colors.gen.dart';
import 'package:todo/models/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final void Function(bool value)? onCheckBoxTap;

  const TaskTile({
    Key? key,
    required this.task,
    this.onCheckBoxTap,
  }) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late bool _done;

  @override
  void initState() {
    _done = widget.task.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 16.0, 12.0),
      decoration: BoxDecoration(
        color: ColorName.card,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.0,
            child: Checkbox(
              value: _done,
              activeColor: ColorName.primary,
              checkColor: ColorName.background,
              side: const BorderSide(width: 2.0, color: ColorName.secondaryText),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: const CircleBorder(),
              onChanged: (value) {
                setState(() => _done = value!);
                widget.onCheckBoxTap?.call(value!);
              },
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              widget.task.content,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}

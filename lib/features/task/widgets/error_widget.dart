import 'package:flutter/material.dart';
import 'package:todo/gen/colors.gen.dart';

class ErrorFailureWidget extends StatelessWidget {
  final String? message;

  const ErrorFailureWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? 'Well, error happens! 😭',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: ColorName.primary,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

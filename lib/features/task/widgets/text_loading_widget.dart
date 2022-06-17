import 'package:flutter/material.dart';
import 'package:todo/gen/colors.gen.dart';

class TextLoadingWidget extends StatelessWidget {
  const TextLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Please wait it's happening... ✨",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          color: ColorName.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}